# 🛒 Retail Sales Analysis - SQL Project

## 📌 Project Overview
This project involves a comprehensive exploratory data analysis (EDA) and business performance evaluation of a retail sales dataset using *SQL*. The goal is to clean the raw transaction data, analyze customer demographics, track sales and revenue trends, and identify top-performing product categories to help drive data-backed business decisions.

---

## 🛠️ Tools & Technologies Used
- **Database Management System:** PostgreSQL 
- **Query Tool/IDE:** pgAdmin 4
- **Language:** SQL (Data Cleaning, Aggregations, Window Functions, Date-Time Functions)

---

## 🗂️ Database Schema & Dataset

The dataset contains retail transaction records with the following primary attributes:
- transaction_id: Unique identifier for each transaction
- sale_date & sale_time: Date and time of purchase
- customer_id: Unique ID of the customer
- gender: Gender of the customer
- age: Age of the customer
- category: Product category (e.g., Clothing, Electronics, Beauty)
- quantity: Number of units purchased
- price_per_unit: Cost per unit
- cogs: Cost of Goods Sold
- total_sale: Total revenue from the transaction

---

## 🔍 Key Business Problems & SQL Solutions

### 1. Data Cleaning (Handling Null/Missing Values)
```sql
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL OR
    sale_date IS NULL OR
    customer_id IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    total_sale IS NULL;
```

### 2. Category-wise Sales & Total Orders
Find the total revenue and total orders for each product category:
```sql
SELECT 
    category,
    COUNT(*) AS total_orders,
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;
```

### 3. Customer Demographics Analysis
Find the average age of customers purchasing from the 'Beauty' category:
```sql
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 4. High-Value Transactions
Retrieve all transactions where the total sale amount is greater than 1000:
```sql
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;
```

### 5. Sales Performance by Shifts (Morning, Afternoon, Evening)
Segment sales into shifts to understand peak business hours:
```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders,
    SUM(total_sale) AS total_revenue
FROM hourly_sales
GROUP BY shift
ORDER BY total_revenue DESC;
```

---

## 📊 Key Findings & Insights
- **Top Performing Categories:** Clothing and Electronics generated the highest overall revenue and order volume.
- **Customer Segmentation:** Distinct age groups show specific shopping behaviors, with beauty products attracting younger to middle-aged demographics.
- **Peak Operational Shifts:** Evening and afternoon shifts generated the maximum customer footfall and sales transactions.
- **High-Value Customers:** A focused group of repeat high-value customers contributed significantly to total revenue.

---

## 🚀 How to Run the Project
1. Clone this repository:
   ```bash
   git clone https://github.com/akashgorai05/SQL-retail-sales-analysis.git
   ```
  
2. Open your preferred SQL database management tool (e.g., pgAdmin, MySQL Workbench).
3. Run the database schema creation script from retail_sales_project1.sql.
4. Import the dataset (.csv file) into the created table.
5. Execute the analysis queries to view the business reports.
