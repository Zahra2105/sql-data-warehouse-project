-- segment products into cost ranges and count how many products fall into each segment.
SELECT 
	COUNT(product_name) AS product_number,
	flag_cost
FROM(
	SELECT 
		product_name,
		cost,
		CASE 
			WHEN cost BETWEEN 0 AND 500 THEN 'LOW COST'
			WHEN cost BETWEEN 501 AND 1000 THEN 'MEDIUM COST'
			WHEN cost BETWEEN 1001 AND 1500 THEN 'HIGH COST'
			ELSE 'VERY HIGH COST'
		END AS flag_cost
	FROM GOLD.dim_product) t
GROUP BY flag_cost


/*Group customers into three segments based on their spending behavior:
   - VIP: Customers with at least 12 months of history and spending more than €5,000.
   - Regular: Customers with at least 12 months of history but spending €5,000 or less.
   - New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH lifespan_customer AS (
	SELECT 
		c.customer_key,
		SUM(f.sales_amount) AS total_sales,
		MIN(f.order_date) AS first_date,
		MAX(f.order_date) AS last_date,
		DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) AS lifespan
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_customer AS c
		ON f.customer_key = c.customer_key
	WHERE f.order_date IS NOT NULL
	GROUP BY c.customer_key
),
customer_cat AS (
	SELECT 
		customer_key, 
		total_sales,
		lifespan,
		CASE 
			WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
			WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS cust_cat
	FROM lifespan_customer
)
SELECT 
	cust_cat,
	COUNT(customer_key) AS total_customer
FROM customer_cat
GROUP BY cust_cat
ORDER BY total_customer DESC;
