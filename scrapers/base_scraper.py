# scrapers/base_scraper.py
from abc import ABC, abstractmethod

class BaseScraper(ABC):
    def __init__(self, url, headers=None):
        self.url = url
        self.headers = headers if headers else {}
    
    @abstractmethod
    def scrape(self):
        pass
