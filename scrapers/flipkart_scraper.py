# scrapers/flipkart_scraper.py
from .base_scraper import BaseScraper
from bs4 import BeautifulSoup
import requests
import pandas as pd
import re

class FlipkartScraper(BaseScraper):
    def __init__(self, url, headers=None, max_pages=30):
        super().__init__(url, headers)
        self.max_pages = max_pages
    
    def get_random_user_agent(self):
        return "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    
    def scrape(self):
        headers = self.headers.copy()
        headers['User-Agent'] = self.get_random_user_agent()
        headers['Accept-Language'] = 'en-US, en;q=0.5'
        headers['Accept-Encoding'] = 'gzip, deflate, br'
        headers['Connection'] = 'keep-alive'
        headers['Referer'] = 'https://www.google.com/'
        
        all_product_names = []
        all_prices = []
        all_ratings = []
        
        try:
            for page in range(1, self.max_pages + 1):
                page_url = f"{self.url}&page={page}"
                response = requests.get(page_url, headers=headers)
                if response.status_code != 200:
                    break  # Stop scraping if a page fails
                soup = BeautifulSoup(response.text, "html.parser")
                product_containers = soup.find_all("div", {"data-id": True})
                
                for container in product_containers:
                    name_tag = container.find("a", class_="wjcEIp")
                    name = name_tag.text.strip() if name_tag else ""
                    all_product_names.append(name)
                    
                    price_tag = container.find("div", class_="Nx9bqj")
                    price = price_tag.text.strip() if price_tag else ""
                    all_prices.append(price)
                    
                    rating_tag = container.find("div", class_="XQDdHH")
                    rating = rating_tag.text.strip() if rating_tag else "No rating"
                    all_ratings.append(rating)
            
            # Clean and prepare DataFrame
            df = pd.DataFrame({
                "Product Name": all_product_names,
                "Prices": all_prices,
                "Ratings": all_ratings
            })
            
            df['Prices'] = df['Prices'].apply(self.clean_price)
            return df, None
        except Exception as e:
            return None, str(e)
    
    def clean_price(self, price_str):
        cleaned_price = re.sub(r'[^\d.,₹]', '', price_str)
        primary_price = re.match(r'₹\d{1,3}(,\d{3})*(\.\d{2})?', cleaned_price)
        return primary_price.group(0) if primary_price else cleaned_price
