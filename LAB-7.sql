--1.
SELECT DISTINCT category_name
FROM categories
WHERE category_id IN
	(SELECT DISTINCT category_id
    FROM products)
ORDER BY category_name;

--2.
SELECT product_name, list_price
FROM products
WHERE list_price > 
	(SELECT AVG(list_price)
    FROM products)
ORDER BY list_price DESC;

--3
SELECT c.category_name 
FROM Categories AS c
WHERE NOT EXISTS
	(SELECT * 
    FROM products AS p
    WHERE p.category_id = c.category_id);
 
--4.
SELECT t1.email_address, t1.order_id, MAX(t1.order_total) AS order_total
FROM
	(SELECT c.email_address, oi.order_id, 
		SUM((item_price - discount_amount) * quantity) AS order_total
	FROM customers AS C
		JOIN orders AS o
			ON c.customer_id = o.customer_id
		JOIN order_items AS oi
        ON o.order_id = oi.order_id
	GROUP BY c.email_address, oi.order_id) AS t1
GROUP BY t1.email_address;

--5.
SELECT product_name, ROUND((discount_amount/item_price)*100,2) AS discount_percent
FROM order_items AS oi
	JOIN products AS p
		ON oi.product_id = p.product_id
GROUP BY discount_percent
HAVING COUNT(*) = 1
ORDER BY product_name;

--6.
SELECT c.email_address, o.order_id, o.order_date
FROM customers AS c
	JOIN orders AS o
		ON c.customer_id = o.customer_id
WHERE o.order_date IN
	(SELECT MIN(o.order_date)
    FROM orders AS o
	GROUP BY order_id);