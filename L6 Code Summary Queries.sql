/* 1. Write a SELECT statement that returns these columns: 

		The count of the number of orders in the Orders table
		The sum of the tax_amount columns in the Orders table */

SELECT COUNT(*), SUM(tax_amount) FROM orders;



/* 2. Write a SELECT statement that returns one row for each category that has products with these columns: 

		The category_name column from the Categories table
		The count of the products in the Products table
		The list price of the most expensive product in the Products table */

SELECT category_name, COUNT(*) AS count_of_products, MAX(list_price) AS list_price
FROM categories JOIN products
	ON categories.category_id = products.category_id
GROUP BY category_name;



/* 3. Write a SELECT statement that returns one row for each customer that has orders with these columns:

	The email_address column from the Customers table
	The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table
	The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table

Sort the result set in descending sequence by the item price total for each customer. */


SELECT email_address, 
		SUM(item_price * quantity) AS total_price,
		SUM(discount_amount * quantity) AS total_discount
FROM customers JOIN orders
	ON customers.customer_id = orders.customer_id
JOIN order_items
	ON orders.order_id = order_items.order_id
GROUP BY customers.customer_id
ORDER BY SUM(item_price) DESC;



/* 4. Write a SELECT statement that returns one row for each customer that has orders with these columns:

		The email_address from the Customers table
		A count of the number of orders
		The total amount for each order 
			(Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)
		Return only those rows where the customer has more than 1 order.

Sort the result set in descending sequence by the sum of the line item amounts. */

SELECT c.email_address, COUNT(o.order_id) AS num_of_orders, 
	SUM(oi.item_price - oi.discount_amount) * oi.quantity AS total_amount
FROM customers AS c 
JOIN orders AS o
	ON c.customer_id = o.customer_id
JOIN order_items AS oi
	ON o.order_id = oi.order_id
GROUP BY c.customer_id
HAVING num_of_orders > 1
ORDER BY total_amount DESC;



/* 5. Modify the solution to exercise 4 so it only counts 
and totals line items that have an item_price value that’s greater than 400.*/

SELECT c.email_address, COUNT(o.order_id) AS num_of_orders, 
	SUM(oi.item_price - oi.discount_amount) * oi.quantity AS total_amount
FROM customers AS c 
JOIN orders AS o
	ON c.customer_id = o.customer_id
JOIN order_items AS oi
	ON o.order_id = oi.order_id
WHERE item_price > 400
GROUP BY c.customer_id
HAVING num_of_orders > 1
ORDER BY total_amount DESC;



/* 6. Write a SELECT statement that answers this question: What is the total amount ordered for each product? Return these columns:

	The product name from the Products table
	The total amount for each product in the Order_Items 
		(Hint: You can calculate the total amount by subtracting the discount amount from the item price 
		and then multiplying it by the quantity)
	Use the WITH ROLLUP operator to include a row that gives the grand total.

Note: Once you add the WITH ROLLUP operator, 
you may need to use MySQL Workbench’s Execute SQL Script button instead of its Execute Current Statement button to execute this statement. */

SELECT p.product_name,
	SUM(oi.item_price - oi.discount_amount) * oi.quantity AS total_amount
FROM products as p
JOIN order_items as oi
	ON p.product_id = oi.product_id
GROUP BY product_name WITH ROLLUP;



/* 7. Write a SELECT statement that answers this question: 
Which customers have ordered more than one product? Return these columns:

		The email address from the Customers table
		The count of distinct products from the customer’s orders */

SELECT c.email_address,
	count(DISTINCT(oi.product_id)) AS count_of_products
FROM customers AS c
JOIN orders AS o
	ON c.customer_id = o.customer_id
JOIN order_items AS oi
	ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING count_of_products > 1;


