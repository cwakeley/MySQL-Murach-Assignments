/*1. What is displayed after the following query executes? */

The following displayed the number of rows/products in table.
SELECT COUNT(*) AS number_of_products 
FROM products;

/*2. After executing the following query, what is the last name that appears first?*/

The last name that appears first was "Brown"
SELECT last_name 
FROM customers 
ORDER BY last_name, first_name ASC;


/*3. After running the following query, what is the value that appears under the "Price Located" column heading?*/

The value is 5 
SELECT count(*) AS "Price Located" 
FROM order_items 
WHERE item_price > 699.99;
