-- calculate the total sales per month and the running total sales over time
SELECT 
	month_number,
	total_sales,
	SUM(total_sales) OVER(ORDER BY month_number) AS cum_sales
FROM(

	SELECT 
		MONTH(order_date) AS month_number,
		SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY MONTH(order_date)
	) t


