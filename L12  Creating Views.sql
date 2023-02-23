/* 1. Create a view named customer_addresses that shows the shipping and billing addresses for each customer. This view should return these columns from the Customers table:

		customer_id
		email_address
		last_name
		first_name

This view should return these columns from the Addresses table:

		bill_line1
		bill_line2
		bill_city
		bill_state
		bill_zip
		ship_line1
		ship_line2
		ship_city
		ship_state
		ship_zip */

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



/* 2. Write a SELECT statement that returns these columns from the customer_addresses view that you created in problem 1:
		customer_id
		last_name
		first_name
		bill_line1 */

SELECT customer_id, last_name, first_name, bill_line1
FROM customer_addresses;


/* 3. Write an UPDATE statement that updates the Customers table using the customer_addresses view you created in problem 1. 
Set the first line of the shipping address to “1990 Westwood Blvd.” for the customer with an ID of 8. */

UPDATE customer_addresses
SET ship_line1 = '1990 Westwood Blvd.'
WHERE customer_id = '8';



/* 4. Create a view named order_item_products that returns columns from the Orders, Order_Items, and Products tables.
This view should return these columns from the Orders table:

		order_id
		order_date
		tax_amount
		ship_date.

This view should return these columns from the Order_Items table:

		item_price
		discount_amount
		final_price (the discount amount subtracted from the item price)
		quantity
		item_total (the calculated total for the item)

This view should return the product_name column from the Products table. */

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
            
/* 5. Create a view named product_summary that uses the view you created in problem 4. 
This view should return summary information about each product.

Each row should include product_name, order_count (the number of times the product has been ordered) 
and order_total (the total sales for the product). */

CREATE OR REPLACE VIEW product_summary AS
SELECT 
	product_name,
        sum(quantity) as order_count,
        sum(item_total) as order_total
	FROM order_item_products
GROUP BY product_name;
  
  
  
/* 6. Write a SELECT statement that uses the view that you created in problem 5 to get 
total sales for the five best selling products. */

SELECT product_name, SUM(order_total)
FROM product_summary
GROUP BY product_name
ORDER BY order_total DESC
LIMIT 5;

