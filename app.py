# app.py

from flask import Flask, render_template, request, send_file, redirect, url_for, flash, jsonify
import pandas as pd
import io
import mysql.connector
from mysql.connector import Error
from scrapers.flipkart_scraper import FlipkartScraper
from datetime import datetime, timedelta
import pytz
import threading
import time
import logging

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with a secure key in production

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# MySQL database connection details
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',  # Update with your MySQL password
    'database': 'flipkart_scraper_db'
}

# Global variable to store the next run time
next_run_time = None
next_run_lock = threading.Lock()

# Function to insert data into the database
def insert_data_to_db(df, website_id):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        if connection.is_connected():
            cursor = connection.cursor()
            # Insert into scraped_data
            cursor.execute(
                "INSERT INTO scraped_data (website_id) VALUES (%s)",
                (website_id,)
            )
            scraped_data_id = cursor.lastrowid
            logger.info(f"Inserted scraped_data with ID: {scraped_data_id}")
            # Insert into scraped_values
            for index, row in df.iterrows():
                if 'Product Name' in df.columns:
                    data_point_id = 1  # Assuming 1 is for product_name
                    cursor.execute(
                        "INSERT INTO scraped_values (scraped_data_id, data_point_id, value) VALUES (%s, %s, %s)",
                        (scraped_data_id, data_point_id, row['Product Name'])
                    )
                if 'Prices' in df.columns:
                    data_point_id = 2  # Assuming 2 is for price
                    cursor.execute(
                        "INSERT INTO scraped_values (scraped_data_id, data_point_id, value) VALUES (%s, %s, %s)",
                        (scraped_data_id, data_point_id, row['Prices'])
                    )
                if 'Ratings' in df.columns:
                    data_point_id = 3  # Assuming 3 is for rating
                    cursor.execute(
                        "INSERT INTO scraped_values (scraped_data_id, data_point_id, value) VALUES (%s, %s, %s)",
                        (scraped_data_id, data_point_id, row['Ratings'])
                    )
            connection.commit()
            logger.info("Data inserted successfully into scraped_values.")
    except Error as e:
        logger.error(f"Error while inserting data to DB: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Function to handle scheduled scraping
def scheduled_scrape(url, interval_hours):
    global next_run_time
    while True:
        try:
            scraper = FlipkartScraper(url)
            df, error = scraper.scrape()
            if df is not None:
                website_id = 1  # Assuming 1 is the ID for Flipkart in websites table
                insert_data_to_db(df, website_id)
                logger.info("Scheduled scraping completed successfully.")
            else:
                logger.error(f"Scheduled scraping failed: {error}")
        except Exception as e:
            logger.error(f"Exception during scheduled scraping: {e}")

        # Update next_run_time based on user interval
        with next_run_lock:
            next_run_time = datetime.now(pytz.timezone('Asia/Kolkata')) + timedelta(hours=interval_hours)
            logger.info(f"Next scheduled scrape at: {next_run_time.isoformat()}")

        # Sleep for the user-defined interval
        time.sleep(interval_hours * 3600)

# Function to start the scheduled scraping in a background thread
def start_scheduled_scrape(url, interval_hours):
    scrape_thread = threading.Thread(target=scheduled_scrape, args=(url, interval_hours), daemon=True)
    scrape_thread.start()
    logger.info("Background scraping thread started.")

# API endpoint to get next scheduled run time
@app.route('/next_scrape')
def next_scrape():
    with next_run_lock:
        if next_run_time:
            return jsonify({'next_run_time': next_run_time.isoformat()})
    return jsonify({'next_run_time': None}), 404

# Route for homepage
@app.route('/')
def index():
    return render_template('index.html', next_run_time=next_run_time)

# Route to schedule scraping
@app.route('/schedule_scrape', methods=['POST'])
def schedule_scrape():
    global next_run_time

    url = request.form['url']
    interval_hours = int(request.form['interval'])

    if not url:
        flash("URL cannot be empty.", 'danger')
        return redirect(url_for('index'))
    
    if interval_hours < 1:
        flash("Interval must be at least 1 hour.", 'danger')
        return redirect(url_for('index'))

    # Start the scheduled scraping in a background thread
    start_scheduled_scrape(url, interval_hours)
    flash("Scraping scheduled successfully.", 'success')
    return redirect(url_for('index'))

# Route for manual scraping via form
@app.route('/scrape', methods=['POST'])
def scrape_route():
    website = request.form['website']
    url = request.form['url']
    selected_data_points = request.form.getlist('data_points')
    
    # Instantiate the appropriate scraper
    if website == 'flipkart':
        scraper = FlipkartScraper(url)
        website_id = 1  # For database insertion
    else:
        return render_template('error.html', message="Website not supported.")
    
    df, error = scraper.scrape()
    
    if error:
        flash(f'Scraping failed: {error}', 'danger')
        return render_template('error.html', message=error)
    
    # Optionally filter DataFrame based on selected data points
    columns = []
    if 'product_name' in selected_data_points:
        columns.append("Product Name")
    if 'price' in selected_data_points:
        columns.append("Prices")
    if 'rating' in selected_data_points:
        columns.append("Ratings")
    
    logger.info(f"Selected columns: {columns}")
    
    # Check if columns exist in DataFrame
    missing_columns = [col for col in columns if col not in df.columns]
    if missing_columns:
        logger.error(f"Missing columns in DataFrame: {missing_columns}")
        flash(f"Missing columns in scraped data: {', '.join(missing_columns)}", 'danger')
        return render_template('error.html', message=f"Missing columns: {', '.join(missing_columns)}")
    
    df = df[columns]
    
    # Log DataFrame head
    logger.info(f"Filtered DataFrame head:\n{df.head()}")
    
    if df.empty:
        logger.warning("Filtered DataFrame is empty.")
        flash("No data found for the selected features.", 'warning')
        return render_template('error.html', message="No data found for the selected features.")
    
    # Insert the data into the database
    insert_data_to_db(df, website_id)
    
    # Convert DataFrame to HTML with Bootstrap classes
    data_html = df.to_html(classes='table table-striped table-bordered', index=False)
    
    # Generate download URLs
    return render_template('result.html',
                           data=data_html,
                           csv_url=url_for('download_csv_flipkart', url=url),
                           excel_url=url_for('download_excel_flipkart', url=url))

# Download routes
@app.route('/download_csv_flipkart')
def download_csv_flipkart():
    url = request.args.get('url')
    scraper = FlipkartScraper(url)
    df, _ = scraper.scrape()
    
    if df is None or df.empty:
        return "Scraping failed or no data found."
    
    # Convert DataFrame to CSV
    output_csv = io.StringIO()
    df.to_csv(output_csv, index=False)
    output_csv.seek(0)
    
    return send_file(io.BytesIO(output_csv.getvalue().encode()), mimetype='text/csv',
                     download_name='Flipkart_Product_Data.csv',
                     as_attachment=True)

@app.route('/download_excel_flipkart')
def download_excel_flipkart():
    url = request.args.get('url')
    scraper = FlipkartScraper(url)
    df, _ = scraper.scrape()
    
    if df is None or df.empty:
        return "Scraping failed or no data found."
    
    # Convert DataFrame to Excel
    output_excel = io.BytesIO()
    df.to_excel(output_excel, index=False)
    output_excel.seek(0)
    
    return send_file(output_excel, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                     download_name='Flipkart_Product_Data.xlsx',
                     as_attachment=True)

# Route to view stored data
@app.route('/data')
def view_data():
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor(dictionary=True)
        query = """
            SELECT sd.id, w.name as website, sd.scraped_at, sp.name as data_point, sv.value
            FROM scraped_data sd
            JOIN websites w ON sd.website_id = w.id
            JOIN scraped_values sv ON sd.id = sv.scraped_data_id
            JOIN data_points sp ON sv.data_point_id = sp.id
            ORDER BY sd.scraped_at DESC
        """
        cursor.execute(query)
        results = cursor.fetchall()
        connection.close()
        df = pd.DataFrame(results)
        
        # Pivot the DataFrame for better presentation
        if not df.empty:
            df_pivot = df.pivot_table(index=['id', 'website', 'scraped_at'], columns='data_point', values='value', aggfunc='first').reset_index()
            # Convert pivoted DataFrame to HTML with Bootstrap classes
            data_html = df_pivot.to_html(classes='table table-striped table-bordered', index=False)
        else:
            data_html = "<p>No data available.</p>"
        
        return render_template('data.html', data=data_html)
    except Error as e:
        logger.error(f"Error fetching data: {e}")
        return render_template('error.html', message=str(e))

# Route to export data
@app.route('/export_data')
def export_data():
    format = request.args.get('format', 'csv')
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor(dictionary=True)
        query = """
            SELECT sd.id, w.name as website, sd.scraped_at, sp.name as data_point, sv.value
            FROM scraped_data sd
            JOIN websites w ON sd.website_id = w.id
            JOIN scraped_values sv ON sd.id = sv.scraped_data_id
            JOIN data_points sp ON sv.data_point_id = sp.id
            ORDER BY sd.scraped_at DESC
        """
        cursor.execute(query)
        results = cursor.fetchall()
        connection.close()
        df = pd.DataFrame(results)
        
        if df.empty:
            return "No data available to export."
        
        # Pivot the DataFrame for better presentation
        df_pivot = df.pivot_table(index=['id', 'website', 'scraped_at'], columns='data_point', values='value', aggfunc='first').reset_index()
        
        if format == 'csv':
            output = io.StringIO()
            df_pivot.to_csv(output, index=False)
            output.seek(0)
            return send_file(io.BytesIO(output.getvalue().encode()), mimetype='text/csv',
                             download_name='scraped_data.csv', as_attachment=True)
        elif format == 'excel':
            output = io.BytesIO()
            df_pivot.to_excel(output, index=False)
            output.seek(0)
            return send_file(output, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                             download_name='scraped_data.xlsx', as_attachment=True)
        else:
            return "Unsupported format.", 400
    except Error as e:
        logger.error(f"Error exporting data: {e}")
        return render_template('error.html', message=str(e))

if __name__ == '__main__':
    app.run(debug=True)
