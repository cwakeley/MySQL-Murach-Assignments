/ * 1. Write a SELECT statement that returns these four columns from the Products table:

		The list_price column
		A column that uses the FORMAT function to return the list_price column with 1 digit to the right of the decimal point
		A column that uses the CONVERT function to return the list_price column as an integer
		A column that uses the CAST function to return the list_price column as an integer 

Use column aliases for all columns that contain a function. */

SELECT 
	list_price, 
	FORMAT(list_price, 1) AS format_price, 
    CONVERT(list_price, SIGNED) AS convert_price, 
    CAST(list_price AS SIGNED) as cast_price
FROM products;



/* 2. Write a SELECT statement that returns these columns from the Products table:

		The date_added column
		A column that uses the CAST function to return the date_added column with its date only (year, month, and day)
		A column that uses the CAST function to return the date_added column with just the year and the month
		A column that uses the CAST function to return the date_added column with its full time only (hour, minutes, and seconds) 
 
Use column aliases for all columns that contain a function. */
 
SELECT 
	date_added,
    CAST(date_added AS DATE) AS date_only,
    CAST(date_added AS CHAR(7)) AS 'year_month',
    CAST(date_added AS TIME) AS 'time_only'
FROM products;


