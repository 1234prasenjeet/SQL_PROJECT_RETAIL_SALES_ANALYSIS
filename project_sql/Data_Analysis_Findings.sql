-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT *
 FROM   
    retail_sale
WHERE   
    sales_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM
    retail_sale
WHERE
    category = 'Clothing'
AND 
    TO_CHAR(sales_date, 'YYYY-MM') =  '2022-11'
AND
    quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
SELECT 
    category,
    SUM(total_safe) as net_sale,
    COUNT(*) as total_orders
FROM
    retail_sale
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
   ROUND(AVG(age),1) as avg_age
FROM
    retail_sale
WHERE
    category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM
    retail_sale
WHERE
    total_safe >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
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

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
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

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
    category,
    COUNT(DISTINCT customer_id) as unique_customer
FROM    
    retail_sale
GROUP BY
    category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
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

-- Q.11 Write a SQl Query To Determine Category with the Highest Profit Margins.
SELECT
    category,
    ROUND(AVG(price_per_unit - cogs)::numeric,1) as profit_margin
 FROM
     retail_sale
GROUP BY
    category
ORDER BY
    profit_margin DESC ;
    
-- Q.12 Write a SQL Query To Calculate Average Transaction Value by Customer Demographic (Age, Gender).
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

--Q.13 Write a SQL Query To Segment Customers Based on Purchasing Behavior (e.g., High-Value Customers.
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