-- Which 5 products generate the highest revenue?
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_product p
ON  f.product_key= p.product_key   
GROUP BY p.product_name
ORDER BY revenue DESC;

SELECT *
FROM (
	SELECT 
		p.product_name,
		SUM(f.sales_amount) AS revenue,
		RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN  gold.dim_product p
	ON  f.product_key= p.product_key   
	GROUP BY p.product_name
	) t
WHERE rank_products<=5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_product p
ON  f.product_key= p.product_key   
GROUP BY p.product_name
ORDER BY revenue ASC;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS sales_amount
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customer c
ON  f.customer_key= c.customer_key   
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY sales_amount DESC;


-- The 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_order
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customer c
ON  f.customer_key= c.customer_key   
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_order ASC;
