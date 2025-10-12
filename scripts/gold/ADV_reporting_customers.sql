/*
=========================================================
Customer Report
=========================================================
Purpose:
 - This report consolidates key customer metrics and behaviors

Highlights:
 1. Gathers essential fields such as names, ages, and transaction details.
 2. Segments customers into categories (VIP, Regular, New) and age groups.
 3. Aggregates customer-level metrics:
    - total orders
    - total sales
    - total quantity purchased
    - total products
    - lifespan (in months)
 4. Calculates valuable KPIs:
    - recency (months since last order)
    - average order value
    - average monthly spend
*/

CREATE VIEW gold.report_customers AS
WITH base_query AS(
    SELECT 
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_id,
        c.customer_number,
        c.customer_key,
        CONCAT(c.first_name,' ',c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
    FROM GOLD.fact_sales f
    LEFT JOIN GOLD.dim_customer c
            ON f.customer_key= c.customer_key
    WHERE order_date IS NOT NULL),
customer_aggregation AS (
    SELECT 
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT(order_number)) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan 
    FROM base_query
    GROUP BY 
        customer_key,
        customer_number,
        customer_name,
        age) 
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    total_orders,
    total_sales,
    total_products,
    lifespan,
    CASE 
			WHEN age<20  THEN 'UNDER 20'
			WHEN age >= 20 AND total_sales <29 THEN '20-29'
            WHEN age >= 30 AND total_sales <39 THEN '20-29'
            WHEN age >= 40 AND total_sales <49 THEN '20-29'
			ELSE '50 AND ABOVE '
		END AS age_group,
    CASE 
			WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
			WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS customer_segmentation,
    last_order_date,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
    total_sales/NULLIF(total_orders,0) AS average_order_value,
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales/ lifespan
    END AS monthly_spend
FROM customer_aggregation
