# E-Commerce Analytics Dashboard (Jan–Jun 2026)

## Overview
An interactive Tableau dashboard designed to monitor and analyze e-commerce performance metrics for the first half of 2026. The dashboard provides high-level business KPIs alongside deep-dive analytical charts to track revenue trends and category performance against targets.

## Live Dashboard
🔗 **[View Interactive Dashboard on Tableau Public](https://public.tableau.com/views/capstone1_17891933142720/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## Key Features & Visuals

* **Top KPI Cards:**
  * **Total Revenue (₹):** Aggregate earnings across all orders.
  * **Total Delivered Orders:** Total count of completed deliveries.
  * **Average Order Value (AOV):** Mean value per processed order.
  * **Categories Meeting Target:** Real-time count of product categories hitting set goals (out of 6).

* **Analytical Visuals:**
  * **Monthly Revenue Trend:** Line chart illustrating revenue progression from January to June 2026.
  * **Category Performance Tiers:** Color-coded bar chart displaying performance against target thresholds (Green/Orange/Red).

* **Interactivity:**
  * Global category filtering—clicking any category bar dynamically filters the monthly line chart and updates all KPI card calculations across the board.

---

## Technical Stack
* **BI Tool:** Tableau Public / Tableau Desktop
* **Calculations:** Custom LOD & conditional AGG formulas for AOV and Target Met status
* **Data Range:** Jan 2026 – Jun 2026


# BigBasket E-Commerce Analytics Dashboard (Jan–Jun 2026)

## Overview
This project presents an end-to-end data analytics and business intelligence solution built for BigBasket to monitor performance across the first half of 2026 (Jan–Jun). Integrating SQL database querying, spreadsheet financial modeling, and an interactive Tableau dashboard, this repository provides clear visibility into key performance indicators (KPIs), category target tracking, monthly revenue trends, and operational metrics to drive data-informed retail strategies.

---

## Repository Structure
```text
bigbasket-capstone/
├── generate_data.py            # Python script to generate SQLite DB & raw data exports
├── data/
│   ├── bigbasket.db            # SQLite database file
│   └── raw_exports/            # CSV exports generated from database
├── sql/
│   ├── task1_kpis.sql          # SQL queries for core KPI calculations
│   ├── task2_monthly.sql       # SQL queries for monthly trend analysis
│   └── task3_categories.sql    # SQL queries for category target evaluations
├── spreadsheets/
│   └── BigBasket_Financial_Model.xlsx # Spreadsheet workbook containing models & pivot tables
├── notebooks/
│   └── Part4_Analysis.ipynb    # Part 4 Jupyter Notebook for exploratory data analysis
├── ai_log.md                   # Log of AI prompts, code generations, and workflows
└── README.md                   # Main project documentation & Data Story