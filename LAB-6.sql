--1
SELECT COUNT(*), SUM(tax_amount) FROM orders;

--2.
SELECT category_name, COUNT(*) AS count_of_products, MAX(list_price) AS list_price
FROM categories JOIN products
	ON categories.category_id = products.category_id
GROUP BY category_name;

--3.
SELECT email_address, 
		SUM(item_price * quantity) AS total_price,
		SUM(discount_amount * quantity) AS total_discount
FROM customers JOIN orders
	ON customers.customer_id = orders.customer_id
JOIN order_items
	ON orders.order_id = order_items.order_id
GROUP BY customers.customer_id
ORDER BY SUM(item_price) DESC;

--4.
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

--5.
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

--6.
SELECT p.product_name,
	SUM(oi.item_price - oi.discount_amount) * oi.quantity AS total_amount
FROM products as p
JOIN order_items as oi
	ON p.product_id = oi.product_id
GROUP BY product_name WITH ROLLUP;

--7.
SELECT c.email_address,
	count(DISTINCT(oi.product_id)) AS count_of_products
FROM customers AS c
JOIN orders AS o
	ON c.customer_id = o.customer_id
JOIN order_items AS oi
	ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING count_of_products > 1;