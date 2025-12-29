# tasks/workers.py
import time
import redis
import dramatiq
import requests
from bs4 import BeautifulSoup
from company_scan import broker

r = redis.Redis()

@dramatiq.actor(store_results=True)
def stock_scraper(task_id, ticket):
    # Scraping Stock Info
    try:
        income_url = f"https://stockanalysis.com/stocks/{ticket}/financials/"
        balance_url = f"https://stockanalysis.com/stocks/{ticket}/financials/balance-sheet/"
        cash_url = f"https://stockanalysis.com/stocks/{ticket}/financials//cash-flow-statement/"
        r.set(f"progress:{task_id}", 10)

        income_response = requests.get(income_url)
        balance_response = requests.get(balance_url)
        cash_response = requests.get(cash_url)
        r.set(f"progress:{task_id}", 20)
        time.sleep(1)

        income_soup = BeautifulSoup(income_response.text, "html.parser")
        balance_soup = BeautifulSoup(balance_response.text, "html.parser")
        cash_soup = BeautifulSoup(cash_response.text, "html.parser")
        r.set(f"progress:{task_id}", 30)

        income_table = income_soup.find("table")
        balance_table = balance_soup.find("table")
        cash_table = cash_soup.find("table")
        all_table = [income_table, balance_table, cash_table]
        r.set(f"progress:{task_id}", 40)
        time.sleep(1)

        all_rows = []
        for table in all_table:
            all_rows.extend(table.find_all("tr"))
        r.set(f"progress:{task_id}", 50)

        fiscar_years = []
        headers = all_rows[0]
        for header in headers.find_all('th'):
            if 'FY' in header.text:
                formated_header = header.text.lower().replace('fy ', '')
                fiscar_years.append(formated_header)
        r.set(f"progress:{task_id}", 60)
        time.sleep(1)

        stock_data = {}
        for i, fiscar_year in enumerate(fiscar_years):
            stock_data[fiscar_year] = {}
            for row in all_rows:
                cells = [cell.text.strip() for cell in row.find_all('td')]
                finance_info = cells[0].lower() if len(cells) > 0 else None
                if finance_info != None:
                    finance_value = cells[i+1].replace(',', '')
                    stock_data[fiscar_year][finance_info] = finance_value
        r.set(f"progress:{task_id}", 70)
    except:
        stock_data = {}

    # Ratios
    roic_list = []
    for year in stock_data.keys():
        free_cash_flow = float(stock_data[year].get("free cash flow", 0))
        total_debt = float(stock_data[year].get("total debt", 0))
        total_equity = float(stock_data[year].get("shareholders' equity", 0))
        cash_equivalents = float(stock_data[year].get("cash & equivalents", 0))
        invested_capital = total_debt + total_equity - cash_equivalents

        roic = round(free_cash_flow / invested_capital * 100, 2)
        roic_list.append(roic)
    
    num_years = len(stock_data.keys())
    roic_avg = round(sum(roic_list) / num_years, 2)
    r.set(f"progress:{task_id}", 80)
    time.sleep(1)
    
    recent_year = list(stock_data.keys())[0]
    recent_total_debt = float(stock_data[recent_year].get("total debt", 0))
    recent_fcf = float(stock_data[recent_year].get("free cash flow", 0)) 

    debt_to_fcf = round(recent_total_debt / recent_fcf, 2) if recent_total_debt != 0 else 0
    r.set(f"progress:{task_id}", 90)
    
    stock_ratios = {"years": num_years, "roic mean": roic_avg, "debt to fcf": debt_to_fcf}
    r.set(f"progress:{task_id}", 100)

    r.set(f"result:{task_id}", str(stock_ratios))
    return "done"
