-- see sales_amount over time (by order_date)
SELECT 
	order_date,
	sales_amount
FROM gold.fact_sales
WHERE order_date IS NOT NULL
ORDER BY order_date;

--aggregate sales_amount by year
SELECT 
	YEAR(order_date),
	SUM(sales_amount) AS  total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

--aggregate sales_amount by month
SELECT 
	DATENAME(MONTH,order_date) AS month_name,
	SUM(sales_amount) AS  total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date), DATENAME(MONTH,order_date)
ORDER BY MONTH(order_date);

--total sales and customers over years
SELECT 
	YEAR(order_date) AS year_number,
	SUM(sales_amount) AS  total_sales,
	COUNT(DISTINCT(customer_key)) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);
