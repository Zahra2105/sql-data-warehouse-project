--exlore all countries from customers
SELECT DISTINCT
	country
FROM gold.dim_customer;

--EXPLORE ALL PRODUCT CATEGORIES
SELECT DISTINCT
	category
FROM gold.dim_product;

--EXPORE ALL SUBCATEGORIES
SELECT DISTINCT
	subcategory
FROM gold.dim_product;

--exploring all products
SELECT DISTINCT
	category,subcategory, product_name
FROM gold.dim_product
ORDER BY 1,2,3;
