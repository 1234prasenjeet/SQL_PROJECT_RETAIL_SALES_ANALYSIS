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