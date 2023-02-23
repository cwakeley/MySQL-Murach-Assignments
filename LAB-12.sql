--1.
CREATE VIEW customer_addresses AS
	SELECT 
		c.customer_id,
        c.email_address,
        c.last_name,
        c.first_name,
		b.line1 AS bill_line1,
		b.line2 AS bill_line2,
		b.city AS bill_city,
		b.state AS bill_state,
		b.zip_code AS bill_zip,
		s.line1 AS ship_line1,
		s.line2 AS ship_line2,
		s.city AS ship_city,
		s.state AS ship_state,
		s.zip_code AS ship_zip
FROM customers AS c
	JOIN
		addresses AS b
			ON c.customer_id = b.customer_id
            AND c.billing_address_id = b.address_id
	JOIN
		addresses AS s
			ON c.customer_id = s.customer_id
            AND c.shipping_address_id = s.address_id;

--2.
SELECT customer_id, last_name, first_name, bill_line1
FROM customer_addresses;


--3.
UPDATE customer_addresses
SET ship_line1 = '1990 Westwood Blvd.'
WHERE customer_id = '8';


/* check to see if tax amount is needed*/
--4.;
CREATE VIEW order_item_products AS
	SELECT 
		o.order_id,
        o.order_date,
        o.tax_amount,
        o.ship_date,
        oi.item_price,
        oi.discount_amount,
        (oi.item_price - oi.discount_amount) as final_price,
        oi.quantity,
        ((oi.item_price - oi.discount_amount) * oi.quantity) AS item_total,
        p.product_name
	FROM orders as o
		JOIN order_items as oi
			ON o.order_id = oi.order_id
		JOIN products as p
			ON oi.product_id = p.product_id;
            
--5.          
CREATE OR REPLACE VIEW product_summary AS
	SELECT 
		product_name,
        sum(quantity) as order_count,
        sum(item_total) as order_total
	FROM order_item_products
    GROUP BY product_name;
    
--6.
SELECT product_name, SUM(order_total)
FROM product_summary
GROUP BY product_name
ORDER BY order_total DESC
LIMIT 5;