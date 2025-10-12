-- Find the Total Sales
-- Find how many items are sold
-- Find the average selling price
-- Find the Total number of Orders
-- Find the total number of products
-- Find the total number of customers
-- Find the total number of customers that has placed an order

SELECT
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_transactions,
AVG(price) AS  average_price,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;


SELECT
'total_products' AS measure_name,
COUNT(product_name) AS measure_value
FROM gold.dim_product;

SELECT
COUNT( DISTINCT product_name) AS total_products
FROM gold.dim_product;

SELECT
COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customer;

SELECT 
COUNT(DISTINCT customer_key)
FROM gold.fact_sales 


--generate a report to show the all metrics
SELECT 'total_sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total_transactions' AS measure_name,SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'average_price' AS measure_name, AVG(price) AS  measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total_orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total_products' AS measure_name, COUNT( DISTINCT product_name) AS measure_value FROM gold.dim_product
UNION ALL
SELECT 'total_customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.dim_customer
UNION ALL
SELECT 'total_customers_placed_orders' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.fact_sales;
