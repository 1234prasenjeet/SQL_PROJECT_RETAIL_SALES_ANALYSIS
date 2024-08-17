COPY retail_sale 
FROM 'D:\SQL_PROJECT_RETAIL_SALES_ANALYSIS\CSV_files\SQL - Retail Sales Analysis_utf .csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

