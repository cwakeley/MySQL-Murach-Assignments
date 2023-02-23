--1.
SELECT product_code, product_name, list_price, discount_percent
FROM PRODUCTS
ORDER BY list_price DESC;

--2.
SELECT concat(last_name, ',', first_name) as full_name
FROM customers
WHERE last_name REGEXP '^[M-Z]'
ORDER BY last_name ASC;

--3.
SELECT product_name, list_price, date_added
FROM products
WHERE list_price > 500 and list_price < 2000
ORDER BY date_added DESC;

--4.
SELECT product_name, list_price, discount_percent, 
	ROUND(list_price*discount_percent/100,2) AS 'discount_amount', 
    list_price-'discount_amount' AS 'discount_price'
FROM products
ORDER BY discount_price desc
LIMIT 5;

--5.
SELECT item_id, item_price, discount_amount,
	quantity, item_price*quantity as 'price_total',
    discount_amount*quantity as 'discount_total',
    (item_price-discount_amount)*quantity as 'item_total'
FROM order_items
WHERE (item_price-discount_amount)*quantity > 500
ORDER BY ((item_price-discount_amount)*quantity) DESC;

--6.
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NOT NULL;

--7.
SELECT NOW() AS today_unformatted, DATE_FORMAT(NOW(), '%D-%b-%y') AS 'today_formatted';

--8.
SELECT 100 as price, .07 as tax_rate, 100*.07 as tax_amount, (100*.07)+100 as total;