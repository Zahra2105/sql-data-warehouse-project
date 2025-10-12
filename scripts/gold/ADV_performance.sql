-- Analyze the yearly performance of products by comparing each product’s sales to both its
-- average sales performance and the previous year’s sales.
WITH sales_amount AS (
	SELECT 
		YEAR(f.order_date) AS order_date,
		p.product_name,
		SUM(f.sales_amount) AS total_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_product p
			ON f.product_key = p.product_key
	WHERE f.order_date IS NOT NULL
	GROUP BY YEAR(f.order_date) , p.product_name
	),
prev_sales AS(
	SELECT
		*,
		AVG(total_sales) OVER (PARTITION BY product_name) AS avg_sales,
		LAG(total_sales) OVER( PARTITION BY product_name ORDER BY order_date) AS pre_sale
	FROM sales_amount)
SELECT 
	*,
	COALESCE((total_sales - pre_sale ),0) AS yoy,
	COALESCE((total_sales - avg_sales),0) AS current_to_average,
	CASE
		WHEN total_sales - pre_sale> 0 THEN 'ABOVE_AVERAGE'
		WHEN total_sales - pre_sale<0  THEN 'BELOW_AVERAGE'
		ELSE 'AVERAGE'
	END AS flag_average,
	CASE
		WHEN total_sales - pre_sale> 0 THEN 'INCREASE'
		WHEN total_sales - pre_sale<0  THEN 'DECREASE'
		ELSE 'NO CHANGE'
	END AS flag_average
FROM prev_sales
ORDER BY order_date



