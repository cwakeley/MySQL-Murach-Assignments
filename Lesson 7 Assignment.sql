/* 1. Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. 
Instead, use a subquery in a WHERE clause that uses the IN keyword.

		SELECT DISTINCT category_name
		FROM categories c JOIN products p
			ON c.category_id = p.category_id
		ORDER BY category_name; */

SELECT DISTINCT category_name
FROM categories
WHERE category_id IN
	(SELECT DISTINCT category_id
    FROM products)
ORDER BY category_name;



/* 2. Write a SELECT statement that answers this question: 

Which products have a list price that’s greater than the average list price for all products?

Return the product_name and list_price columns for each product. */

Sort the results by the list_price column in descending sequence.
SELECT product_name, list_price
FROM products
WHERE list_price > 
	(SELECT AVG(list_price)
    FROM products)
ORDER BY list_price DESC;




/* 3. Write a SELECT statement that returns the category_name column from the Categories table.
Return one row for each category that has never been assigned to any product in the Products table. 
To do that, use a subquery introduced with the NOT EXISTS operator. */

SELECT c.category_name 
FROM Categories AS c
WHERE NOT EXISTS
	(SELECT * 
    FROM products AS p
    WHERE p.category_id = c.category_id);
 
 
 
/* 4. Write a SELECT statement that returns three columns: 

	email_address 
	order_id
	the order total for each customer.

To do this, you can group the result set by the email_address and order_id columns. 
In addition, you must calculate the order total from the columns in the Order_Items table. 

Write a second SELECT statement that uses the first SELECT statement in its FROM clause. 
The main query should return two columns: the customer’s email address and the largest order for that customer. 
To do this, you can group the result set by the email_address. */

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




/* 5. Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. 
In other words, don’t include products that have the same discount percent as another product.
Sort the results by the product_name column. */

SELECT product_name, ROUND((discount_amount/item_price)*100,2) AS discount_percent
FROM order_items AS oi
	JOIN products AS p
		ON oi.product_id = p.product_id
GROUP BY discount_percent
HAVING COUNT(*) = 1
ORDER BY product_name;



/* 6. Use a correlated subquery to return one row per customer, representing the customer’s oldest order (the one with the earliest date). 
Each row should include these three columns: email_address, order_id, and order_date. */

SELECT c.email_address, o.order_id, o.order_date
FROM customers AS c
	JOIN orders AS o
		ON c.customer_id = o.customer_id
WHERE o.order_date IN
	(SELECT MIN(o.order_date)
    FROM orders AS o
	GROUP BY order_id);
	
	
