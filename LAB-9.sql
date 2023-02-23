--1. 
SELECT list_price, discount_percent, ROUND( list_price * discount_percent/100), 2) as discount_amount
FROM products;

--2.
SELECT 
	order_date, 
	DATE_FORMAT(order_date, '%Y') as four_year, 
    DATE_FORMAT(order_date, '%b-%d-%Y') as abbr_month, 
    DATE_FORMAT(order_date, '%l:%i %p') as date_time,
    DATE_FORMAT(order_date, '%m/%d/%y %H:%S')
FROM orders;

--3.
SELECT 
	card_number,
    length(card_number) as length,
    RIGHT(card_number, 4) as last_four,
    INSERT(RIGHT(card_number, 4), 1, 0, 'XXXX-XXXX-XXXX-') as four_format
FROM orders;

--4.
SELECT 
	order_id, 
    order_date, 
    DATE_ADD(order_date, INTERVAL 2  DAY) as approx_ship_date,
    ship_date,
    DATEDIFF(ship_date, order_date) as days_to_ship    
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = '5' AND EXTRACT(YEAR FROM order_date) = '2012';


