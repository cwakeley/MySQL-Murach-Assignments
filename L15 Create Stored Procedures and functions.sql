/* 1. Write a script that creates and calls a stored procedure named insert_category. 
First, code a statement that creates a procedure that adds a new row to the Categories table. 
To do that, this procedure should have one parameter for the category name.
Code at least two CALL statements that test this procedure. (Note that this table doesn’t allow duplicate category names.) */

DROP PROCEDURE IF EXISTS insert_category

DELIMITER //

CREATE PROCEDURE insert_category
	(category_name_par VARCHAR(50))

BEGIN
	INSERT INTO categories (category_id, category_name)
	VALUES (DEFAULT, category_name_par);
END//

DELIMITER ;

CALL insert_category('Brass');
CALL insert_category('Drums');


/* 2. Write a script that creates and calls a stored function named 
discount_price that calculates the discount price of an item in the Order_Items table 
(discount amount subtracted from item price). 
To do that, this function should accept one parameter for the item ID, 
and it should return the value of the discount price for that item. */

DROP FUNCTION IF EXISTS discount_price;

DELIMITER //

CREATE FUNCTION discount_price
	(item_id_par INT)
    
RETURNS DECIMAL(9,2)
DETERMINISTIC READS SQL DATA
BEGIN

    DECLARE discount_price_var DECIMAL(9,2);
    
    SELECT item_price - discount_amount
    INTO discount_price_var
    FROM order_items
    WHERE item_id = item_id_par;
    
    RETURN discount_price_var;
    
END//

DELIMITER ;

SELECT item_id, item_price, discount_amount, discount_price(item_id) as discount_price
FROM order_items;

/* 3. Write a script that creates and calls a stored function named item_total that calculates 
the total amount of an item in the Order_Items table (discount price multiplied by quantity). 
To do that, this function should accept one parameter for the item ID, 
it should use the discount_price function that you created in exercise 2, 
and it should return the value of the total for that item. */

DROP FUNCTION IF EXISTS item_total;

DELIMITER //

CREATE FUNCTION item_total
	(item_id_par INT)

RETURNS DECIMAL (9,2)
DETERMINISTIC READS SQL DATA
BEGIN

DECLARE total_amount_var DECIMAL(9,2);
    
    SELECT quantity * discount_price(item_id_par)
    INTO total_amount_var
    FROM order_items
    WHERE item_id = item_id_par;
    
    return total_amount_var;
END//

DELIMITER ;

SELECT item_id, discount_price(item_id) AS discount_price
FROM order_items;

/* 4. Write a script that creates and calls a stored procedure named insert_products that 
inserts a row into the Products table. This stored procedure should accept five parameters, 
one for each of these columns: category_id, product_code, product_name, list_price, and discount_percent.
This stored procedure should set the description column to an empty string, 
and it should set the date_added column to the current date.
If the value for the list_price column is a negative number, the stored procedure should raise an 
error that indicates that this column doesn’t accept negative numbers. Similarly, 
the procedure should raise an error if the value for the discount_percent column is a negative number.
Code at least two CALL statements that test this procedure.  */

DROP PROCEDURE IF EXISTS insert_products;

DELIMITER //

CREATE PROCEDURE insert_products
	(
		category_id_par INT,
        product_code_par VARCHAR(50),
        product_name_par VARCHAR(50),
        list_price_par DECIMAL(9,2),
        discount_percent_par DECIMAL(9,2)
	)

BEGIN
	IF (list_price_par < 0) THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'The list price must be positive',
				MYSQL_ERRNO = 1264;
	END IF;
	IF (discount_percent_par < 0) THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'The discount percentage must be positive',
				MYSQL_ERRNO = 1264;
	END IF;
    
    INSERT INTO products
		(product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added)
	VALUES
		(DEFAULT, category_id_par, product_code_par, product_name_par, ' ', list_price_par, discount_percent_par, NOW());
END//

DELIMITER ;

CALL insert_products(1, 'Guitar123', 'Fender Guitar', -100.00, 50);
CALL insert_products(1, 'Guitar456', 'Fender Guitar2', 100.00, -50);



/* 5. Write a script that creates and calls a stored procedure named update_product_discount that 
updates the discount_percent column in the Products table. This procedure should have one parameter 
for the product ID and another for the discount percent.
If the value for the discount_percent column is a negative number, the stored procedure should 
raise an error that the value for this column must be a positive number.
Code at least two CALL statements that test this procedure. */

DROP PROCEDURE IF EXISTS update_product_discount;

DELIMITER //

CREATE PROCEDURE update_product_discount
(
  product_id_par	INT,
  discount_percent_par	DECIMAL(9,2)
)
BEGIN

  IF discount_percent_par < 0 THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'The discount percent must be positive',
        MYSQL_ERRNO = 1264;  
  END IF;

  UPDATE products
  SET discount_percent = discount_percent_par
  WHERE product_id = product_id_par;
  
END//

DELIMITER ;

CALL update_product_discount(1, -0.02);
CALL update_product_discount(1, 30.5);

SELECT product_id, product_name, discount_percent 
FROM   products 
WHERE  product_id = 1;
