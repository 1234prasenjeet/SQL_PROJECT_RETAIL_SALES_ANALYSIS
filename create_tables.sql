CREATE TABLE retail_sale 
(
    transaction_id INT PRIMARY KEY,
    sales_date DATE,
    sales_time TIME,
    customer_id INT,
    gender VARCHAR(255),
    age INT,
    category VARCHAR(255),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT

);

