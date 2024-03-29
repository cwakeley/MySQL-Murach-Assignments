/* 1. Write a SELECT statement that returns four columns from the Products table: product_code, product_name, list_price, and discount_percent. 
Then, run this statement to make sure it works correctly.
Add an ORDER BY clause to this statement that sorts the result set by list price in descending sequence. 
Then, run this statement again to make sure it works correctly. 
This is a good way to build and test a statement, one clause at a time. */

SELECT product_code, product_name, list_price, discount_percent
FROM PRODUCTS
ORDER BY list_price DESC;

/* 2. Write a SELECT statement that returns one column from the Customers table named full_name that joins the last_name and first_name columns.

Format this column with the last name, a comma, a space, and the first name like this:
Doe, John
Sort the result set by last name in ascending sequence.

Return only the customers whose last name begins with letters from M to Z. */

SELECT concat(last_name, ',', first_name) as full_name
FROM customers
WHERE last_name REGEXP '^[M-Z]'
ORDER BY last_name ASC;


/* 3. Write a SELECT statement that returns these columns from the Products table:

      product_name
      list_price
      date_added
      
Return only the rows with a list price that’s greater than 500 and less than 2000.
Sort the result set in descending sequence by the date_added column. */

SELECT product_name, list_price, date_added
FROM products
WHERE list_price > 500 and list_price < 2000
ORDER BY date_added DESC;

/* 4.Write a SELECT statement that returns these columns from the Products table:

    product_name
    list_price
    discount_percent
    discount_amount
    discount_price
    
Round the discount_amount and discount_price columns to 2 decimal places.
Sort the result set by discount price in descending sequence.
Use the LIMIT clause so the result set contains only the first 5 rows. */


SELECT product_name, list_price, discount_percent, 
	ROUND(list_price*discount_percent/100,2) AS 'discount_amount', 
    list_price-'discount_amount' AS 'discount_price'
FROM products
ORDER BY discount_price desc
LIMIT 5;

/* 5. Write a SELECT statement that returns these column names and data from the Order_Items table: 

      item_id
      item_price
      discount_amount
      quantity
      price_total
      discount_total
      item_total

Only return rows where the item_total is greater than 500.
Sort the result set by item total in descending sequence. */ 

 
SELECT item_id, item_price, discount_amount,
	quantity, item_price*quantity as 'price_total',
    discount_amount*quantity as 'discount_total',
    (item_price-discount_amount)*quantity as 'item_total'
FROM order_items
WHERE (item_price-discount_amount)*quantity > 500
ORDER BY ((item_price-discount_amount)*quantity) DESC;

/* 6. Write a SELECT statement that returns these columns from the Orders table: 

      order_id
      order_date
      ship_date

Return only the rows where the ship_date column contains a null value. */

 
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NOT NULL;

/* 7. Write a SELECT statement without a FROM clause that uses the NOW function to create a row with these columns:

      today_unformatted
      today_formatted

The today_unformatted column should show the results of the NOW function with out any formatting.
The today_formatted column should show the results of the NOW function in the format DD-Mon-YYYY. 
DD for the day number, Mon for an abbreviated month, YYYY for a four digit year.

 
SELECT NOW() AS today_unformatted, DATE_FORMAT(NOW(), '%D-%b-%y') AS 'today_formatted';

/* 8. Write a SELECT statement without a FROM clause that creates a row with these columns and (values): 

      price (100)
      tax_rate (.07)
      tax_amount (The price column multiplied by the tax_rate column)
      total (The price plus the tax_amount)

To calculate the total column, add the expressions you used for the price and tax_amount columns. */

SELECT 100 as price, .07 as tax_rate, 100*.07 as tax_amount, (100*.07)+100 as total;
