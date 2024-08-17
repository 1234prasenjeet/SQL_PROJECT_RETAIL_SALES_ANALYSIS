# Introduction
This project focuses on the analysis of retail sales data using SQL. The goal is to explore, clean, and analyze the data to uncover key business insights. By applying various SQL queries, the project aims to answer critical business questions such as identifying top-selling products by category, determining customer demographics, and analyzing sales trends over time. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

🔍 SQL queries? Check them out here :[project_sql folder](/project_sql/)

# Background
In the competitive retail landscape, understanding sales trends, customer behavior, and product performance is essential for business success. This project focuses on analyzing retail sales data using SQL to extract valuable insights that can inform business strategies and decisions.

Key objectives include:

- **Identify Top-Selling Products:** Determine the best-selling products across categories.
- **Analyze Customer Demographics:** Explore the age and gender profiles of customers by category.
- **Examine Sales Trends:** Identify peak sales periods and top-performing months.
- **Segment Customers:** Classify customers based on purchasing behavior to highlight high-value segments.
- **Optimize Sales Strategies:** Provide insights to refine product offerings, pricing, and marketing.

This project showcases how SQL can be leveraged for data exploration, cleaning, and analysis to address real-world retail challenges, supporting data-driven decision-making.

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

 - **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
 - **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
 - **Visual Studio Code:** My go-to for database management and executing SQL queries.
 - **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# Analysis
Database Setup

- **Database Creation**: The project starts by creating a database named ***sql_retail***.
- **Table Creation:** A table named ***retail_sale*** is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

# Data Exploration & Cleaning

 - **Record Count:** Determine the total number of records in the dataset.
 - **Customer Count:** Find out how many unique customers are in the dataset.
 - **Category Count:** Identify all unique product categories in the dataset.
- **Null Value Check:** Check for any null values in the dataset and delete records with missing data.

```sql
--Data Exploration & Cleaning
SELECT 
    COUNT(*) FROM retail_sale

--
SELECT * 
FROM
    retail_sale
WHERE
    transaction_id IS NULL 
    OR sales_date IS NULL
    OR sales_time IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS  NULL
    OR cogs IS NULL
    OR total_safe IS NULL

/* SINCE age, quantity, price_per_unit, cogs, total_safe
    are having null values so we are going to handle this by removing or  deleting them
*/

DELETE FROM retail_sale
WHERE
    transaction_id IS NULL 
    OR sales_date IS NULL
    OR sales_time IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS  NULL
    OR cogs IS NULL
    OR total_safe IS NULL;

-- How many sales we have ?
SELECT COUNT (*) as total_safe
FROM  
    retail_sale

-- How many unique customer we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale 
FROM    
    retail_sale

SELECT DISTINCT category 
FROM 
    retail_sale
```
    
# Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

### 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
```sql
SELECT *
 FROM   
    retail_sale
WHERE   
    sales_date = '2022-11-05'
```
**Finding:** Extracts complete sales data for November 5, 2022, enabling a focused review of daily sales performance and transactions

### Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
```sql
SELECT *
FROM
    retail_sale
WHERE
    category = 'Clothing'
AND 
    TO_CHAR(sales_date, 'YYYY-MM') =  '2022-11'
AND
    quantity >= 4;
```
**Finding**: Identifies clothing transactions with quantities of 4 or more in November 2022, highlighting significant sales activity in this category.

### Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
```sql
SELECT 
    category,
    SUM(total_safe) as net_sale,
    COUNT(*) as total_orders
FROM
    retail_sale
GROUP BY category
```
**Finding:** Provides total sales and order counts per category, showing which categories drive the most revenue and volume.

### Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```sql
SELECT
   ROUND(AVG(age),1) as avg_age
FROM
    retail_sale
WHERE
    category = 'Beauty'
```
**Finding:** Computes the average age of beauty product buyers, offering insights into the typical demographic for this category.

### Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
```sql
SELECT *
FROM
    retail_sale
WHERE
    total_safe >1000;
```
**Finding:** Identifies high-value transactions exceeding $1000, pinpointing significant sales events and high-spending customers.

### Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```sql
SELECT
    category,
    gender,
    COUNT(transaction_id) as total_trans
FROM
    retail_sale
GROUP BY
    category,
    gender
ORDER BY
    category DESC,
    gender  
```
**Finding:** Shows transaction counts by gender across categories, revealing gender-based buying patterns and category preferences.

### Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
```sql
SELECT
    year,
    month,
    avg_sale
FROM
(
    SELECT
        EXTRACT(YEAR FROM sales_date) as year ,
        EXTRACT(MONTH FROM sales_date) as month,
        ROUND(CAST(AVG(total_safe) AS numeric), 1) as avg_sale,
        Rank() OVER(PARTITION BY EXTRACT(YEAR FROM sales_date) ORDER BY ROUND(CAST(AVG(total_safe) AS numeric), 1 )DESC) as rank
   
    FROM
        retail_sale
    GROUP BY
        year,
        month
) as  t
WHERE   
    rank = 1 ;
```
**Finding:** Determines the average sales per month and highlights the top-selling month for each year, providing insights into peak sales periods.

### Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
```sql
SELECT
    customer_id,
    SUM(total_safe) as total_sales
FROM    
    retail_sale
GROUP BY
    customer_id
ORDER BY 
    total_sales DESC
LIMIT 5 ;
```
**Finding:** Identifies the top 5 customers with the highest total sales, spotlighting key high-value customers.

### Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) as unique_customer
FROM    
    retail_sale
GROUP BY
    category;
```
**Finding:** Counts unique customers per category, indicating customer reach and category popularity.

### Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
```sql
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sales_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_time) Between 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift ,
    COUNT(*) as number_of_orders
FROM
    retail_sale
GROUP BY
    shift
ORDER BY
    shift 
```
**Finding:** Classifies orders into time shifts, helping to understand order distribution throughout the day.

### Q.11 Write a SQl Query To Determine Category with the Highest Profit Margins.
```sql
SELECT
    category,
    ROUND(AVG(price_per_unit - cogs)::numeric,1) as profit_margin
 FROM
     retail_sale
GROUP BY
    category
ORDER BY
    profit_margin DESC ;
 ```   
 **Finding:** Computes the average profit margin per category, highlighting the most profitable categories.

### Q.12 Write a SQL Query To Calculate Average Transaction Value by Customer Demographic (Age, Gender).
```sql
SELECT
    age,
    gender,
    ROUND(avg(total_safe)::numeric,1) as avg_transaction
FROM
    retail_sale
GROUP BY
    age,
    gender
ORDER BY    
    avg_transaction DESC ;
```
**Finding:** Calculates average transaction values based on age and gender, providing demographic-based transaction insights.

### Q.13 Write a SQL Query To Segment Customers Based on Purchasing Behavior (e.g., High-Value Customers.
```sql
SELECT
    customer_id,
    SUM(total_safe) as total_sales,
    COUNT(transaction_id) as total_transactions
FROM
    retail_sale

GROUP BY
    customer_id 

ORDER BY
    total_sales DESC;
```
**Finding:** Segments customers by total sales and transaction count, identifying high-value customers and their purchasing behavior.

# What I Learned
Throughout this project, I’ve refined my SQL skills to tackle complex data challenges with precision and insight:

🔍 **Data Retrieval Mastery:** Learned the art of extracting key data points with targeted SQL queries, ensuring comprehensive and relevant results.

📊 **Aggregative Analysis:** Leveraged SQL aggregation functions to summarize large amounts of data   into actionable insights, revealing trends and patterns.

🧠 **Strategic Insights:** Applied advanced SQL methods to understand important business information and turn raw data into useful advice.

# Conclusions
This project has been a valuable exercise in leveraging SQL to analyze retail sales data. By exploring and cleaning the data, and then applying various SQL queries, we've gained deep insights into sales performance, customer behavior, and product trends.

Key takeaways include:

**Sales Performance:** Identified top-selling products and categories, providing a clearer picture of what drives revenue.

 **Customer Insights:** Analyzed customer demographics and purchasing behavior, helping to better understand who the customers are and how they shop.

**Sales Trends:** Uncovered patterns in sales over time, including peak periods and best-selling months, which can guide inventory and marketing strategies.

**High-Value Segments:** Segmented customers based on their purchasing behavior to highlight high-value segments for targeted marketing efforts.

### Closing Thoughts :
This project demonstrates how SQL can transform complex retail data into actionable insights. By analyzing sales trends, customer behavior, and product performance, we've uncovered key factors influencing business success.

Effective data cleaning and querying are crucial for making informed decisions and improving strategies. This project shows how data analysis can drive business improvements.

Looking ahead, ongoing data analysis will be vital for adapting to market changes and customer needs. The skills gained here will support tackling more advanced data challenges and identifying new growth opportunities.
