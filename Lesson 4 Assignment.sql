--1.
SELECT category_name, product_name, list_price
FROM categories INNER JOIN products
	ON categories.category_id = products.category_id
ORDER BY category_name, product_name ASC;

--2.
SELECT first_name, last_name, city, state, zip_code 
FROM customers INNER JOIN addresses
	ON customers.customer_id = addresses.customer_id
WHERE email_address = 'allan.sherwood@yahoo.com';

--3.
SELECT first_name, last_name, line1, city, state, zip_code
FROM customers INNER JOIN addresses
	ON customers.customer_id = addresses.customer_id
WHERE customers.shipping_address_id = addresses.address_id;

--4.
SELECT last_name, first_name, order_date,
	product_name, item_price, discount_amount, quantity
FROM customers as c
	 JOIN orders as o
		ON c.customer_id = o.customer_id
	 JOIN  order_items as oi
		ON o.order_id = oi.order_id
	 JOIN products as p
		ON oi.product_id = p.product_id
ORDER BY c.last_name, o.order_date, p.product_name;

--5.
SELECT p1.product_name, p1.list_price 
FROM products as p1 
	JOIN products as p2
		ON p1.list_price = p2.list_price AND
        p1.product_name <> p2.product_name;

--6.
SELECT c.category_name, p.product_id
FROM categories as c
	left join products as p
		ON c.category_id = p.category_id
WHERE p.product_id is NULL;

--7.
	SELECT 'SHIPPED' as ship_status, 
		order_id as 'The order_id',
		order_date as 'columnorder_date'
	FROM orders
	WHERE ship_date IS NOT NULL
UNION
	SELECT 'NOT SHIPPED' as ship_status,
		order_id as 'The order_id',
		order_date as 'columnorder_date'
	FROM orders
    WHERE ship_date IS NULL
    ORDER BY columnorder_date; 
