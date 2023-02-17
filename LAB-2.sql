--1. The following displayed the number of rows/products in table.
SELECT COUNT(*) AS number_of_products 
FROM products;
--2. The last name that appears first was "Brown"
SELECT last_name 
FROM customers 
ORDER BY last_name, first_name ASC;
--3.  The value is 5 
SELECT count(*) AS "Price Located" 
FROM order_items 
WHERE item_price > 699.99;
