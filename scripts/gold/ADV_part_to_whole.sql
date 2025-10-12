-- which categories contribute the most to overall sales?


WITH sales_by_cat AS(
	SELECT 
		p.category,
		SUM(f.sales_amount) AS total_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_product p
			ON f.product_key= p.product_key
	GROUP  BY category),
overall_sales AS(
	SELECT 
		*, 
		SUM(total_sales)  OVER() AS total
	FROM sales_by_cat)
SELECT
	*,
	CONCAT(ROUND(CAST(total_sales AS FLOAT)/total * 100,2),'%') AS per_change
FROM overall_sales
ORDER BY total_sales DESC

