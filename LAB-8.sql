--1.
SELECT 
	list_price, 
	FORMAT(list_price, 1) AS format_price, 
    CONVERT(list_price, SIGNED) AS convert_price, 
    CAST(list_price AS SIGNED) as cast_price
FROM products;

--2.
SELECT 
	date_added,
    CAST(date_added AS DATE) AS date_only,
    CAST(date_added AS CHAR(7)) AS 'year_month',
    CAST(date_added AS TIME) AS 'time_only'
FROM products;