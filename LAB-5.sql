/* 1. Write an INSERT statement that adds this row to the Categories table:

		category_name: Brass

Code the INSERT statement so MySQL automatically generates the category_id column. */

INSERT INTO categories 
VALUES (DEFAULT, 'Brass');



/* 2. Write an UPDATE statement that modifies the row you just added to the Categories table. 
This statement should change the category_name column to “Woodwinds”, 
and it should use the category_id column to identify the row. */

UPDATE categories
SET category_name = 'Woodwinds'
WHERE category_id = 
	(SELECT category_id
    FROM categories
    WHERE category_name = 'Brass');



/* 3. Write a DELETE statement that deletes the row you added to the Categories table in exercise 1. 
This statement should use the category_id column to identify the row. */

DELETE FROM categories
WHERE category_id =
	(SELECT category_id 
    FROM categories 
    WHERE category_name = 'Woodwinds');



/* 4. Write an INSERT statement that adds this row to the Products table:
 
		product_id: The next automatically generated ID
		category_id: 4
		product_code: dgx_640
		product_name: YAmaha DGX 640 88-key Digital Piano
		description: Long description to come
		list_price: 799.99
		discount_percent: 0
		date_added: Today's date/time
 
Use a column list for this statement */

INSERT INTO products
	(product_id, category_id, product_code, product_name, description, 	list_price, discount_percent, date_added)
VALUES
	(DEFAULT, 4, 'dgx_640', 'YAmaha DGX 640 88-key Digital Piano', 'Long 	description to come', 799.99, 0, NOW());



/* 5. Write an UPDATE statement that modifies the product you added in exercise 4. 
This statement should change the discount_percent column from 0% to 35%. */ 

UPDATE products
	SET discount_percent = 35
WHERE product_id = 11;



/* 6. Write a DELETE statement that deletes the row that you added to the Products table in exercise 4. */

DELETE FROM products 
WHERE product_id = 11;

/* 7. Write an INSERT statement that adds this row to the Customers table:

		email_address: rick@raven.com
		password: (empty string)
		first_name: Rick
		last_name: Raven

Use a column list for this statement. */

INSERT INTO customers
	(email_address, password, first_name, last_name)
VALUES
	('rick@raven.com', ' ', 'Rick', 'Raven');



/* 8. Write an UPDATE statement that modifies the Customers table. 
Change the password column to “secret” for the customer with an email address of rick@raven.com. */

UPDATE customers
	SET password = 'secret'
WHERE email_address = 'rick@raven.com';



/* 9. Write an UPDATE statement that modifies the Customers table. 
Change the password column to “reset” for every customer in the table. 
If you get an error due to safe-update mode, you can add a LIMIT clause to update the first 100 rows of the table. 
(This should update all rows in the table.) */

UPDATE customers
	SET password = 'reset';
	
	
	
