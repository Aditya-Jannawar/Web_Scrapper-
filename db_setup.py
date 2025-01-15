import mysql.connector
from mysql.connector import Error

# Database configuration
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',  # Update with your MySQL password
    'database': 'flipkart_scraper_db'
}

try:
    connection = mysql.connector.connect(**DB_CONFIG)
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print(f"Connected to MySQL Server version {db_Info}")
        cursor = connection.cursor()
        cursor.execute("SELECT DATABASE();")
        record = cursor.fetchone()
        print(f"You're connected to database: {record[0]}")
except Error as e:
    print(f"Error while connecting to MySQL: {e}")
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
