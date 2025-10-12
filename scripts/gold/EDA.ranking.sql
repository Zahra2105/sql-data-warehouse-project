-- find tha min and max of order date
--how many of years are available
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR, MIN(order_date),MAX(order_date))  AS order_range_years
FROM gold.fact_sales;



--find the youngest and oldest customers
SELECT
	MIN(birthdate) AS oldest,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()),
	MAX(birthdate) AS youngest,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE())
FROM gold.dim_customer;
