Flipkart Scraper Application
This Flask-based application allows you to scrape product data from Flipkart, store it in a MySQL database, and download the results in CSV or Excel format. You can also schedule scraping operations, view stored data, and export data.
Features
•	Scrape Flipkart Data: Scrape product name, prices, and ratings from Flipkart.
•	Store Data in MySQL: Save scraped data in a MySQL database.
•	Download Data: Download the scraped data in CSV or Excel format.
•	Scheduled Scraping: Set scraping intervals and get real-time updates for the next scheduled scrape.
•	View Data: View and export scraped data stored in the database.
Prerequisites
•	Python 3.x
•	MySQL Database
•	Flask
•	Required Python Packages (requirements.txt):
o	pandas
o	mysql-connector-python
o	pytz
Setup Instructions
1.	Clone the repository and navigate to the project directory:
2.	Install the required Python packages:
pip install -r requirements.txt

3.	Set up your MySQL database and update the DB_CONFIG in the app.py file with your database credentials.
4.	Start the Flask app:
bash
Copy code
python app.py

5.	Access the application at:
arduino
Copy code
http://localhost:5000

Usage
•	Scrape Data: Submit a Flipkart URL via the form to scrape data.
•	Schedule Scraping: Set a time interval for recurring scraping from the UI.
•	View Data: Go to /data to view stored scraped data.
•	Export Data: Use /export_data to download data in CSV or Excel format.

