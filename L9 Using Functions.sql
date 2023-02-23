/* 1. Write a SELECT statement that returns these columns from the Products table:

		The list_price column
		The discount_percent column
		A column named discount_amount that uses the previous two columns to calculate the discount amount and uses the 
			ROUND function to round the result so it has 2 decimal digits

Use column aliases for any columns that contain a function or a formula. */

SELECT list_price, discount_percent, ROUND( list_price * discount_percent/100), 2) as discount_amount
FROM products;



/* 2. Write a SELECT statement that returns these columns from the Orders table:

		order_date column
		DATE_FORMAT function to return the four- digit year that’s stored in the order_date column
		DATE_FORMAT function to return the order_date column in this format: Mon-DD-YYYY. 
			In other words, use abbreviated months and separate each date component with dashes.
		DATE_FORMAT function to return the order_date column with only the hours and minutes on a 12-hour clock with an am/pm indicator
		DATE_FORMAT function to return the order_date column in this format: MM/DD/YY HH:SS. 
			In other words, use two-digit months, days, and years and separate them by slashes. 
		Use 2-digit hours and minutes on a 24-hour clock. And use leading zeros for all date/time components. 

Use column aliases for any columns that contain a function or a formula. */

SELECT 
	order_date, 
	DATE_FORMAT(order_date, '%Y') as four_year, 
    DATE_FORMAT(order_date, '%b-%d-%Y') as abbr_month, 
    DATE_FORMAT(order_date, '%l:%i %p') as date_time,
    DATE_FORMAT(order_date, '%m/%d/%y %H:%S')
FROM orders;



/* 3. Write a SELECT statement that returns these columns from the Orders table:

		The card_number column
		The length of the card_number column
		The last four digits of the card_number column 
		When you get that working right, add the columns that follow to the result set. 
			This is more difficult because these columns require the use of functions within functions.

A column that displays the last four digits of the card_number column in this format: XXXX-XXXX-XXXX-1234. In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number. 
Use column aliases for any columns that contain a function or a formula. */

SELECT 
	card_number,
    length(card_number) as length,
    RIGHT(card_number, 4) as last_four,
    INSERT(RIGHT(card_number, 4), 1, 0, 'XXXX-XXXX-XXXX-') as four_format
FROM orders;



/* 4. Write a SELECT statement that returns these columns from the Orders table:

		The order_id column
		The order_date column
		A column named approx_ship_date that’s calculated by adding 2 days to the order_date column
		The ship_date column
		A column named days_to_ship that shows the number of days between the order date and the ship date
	
When you have this working, add a WHERE clause that retrieves just the orders for May 2012.
Use column aliases for any columns that contain a function or a formula. */

SELECT 
	order_id, 
    order_date, 
    DATE_ADD(order_date, INTERVAL 2  DAY) as approx_ship_date,
    ship_date,
    DATEDIFF(ship_date, order_date) as days_to_ship    
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = '5' AND EXTRACT(YEAR FROM order_date) = '2012';


