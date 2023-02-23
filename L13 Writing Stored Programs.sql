/* 1. Write a script that creates and calls a stored procedure named test. 
This stored procedure should declare a variable and set it to the count of all 
products in the Products table. If the count is greater than or equal to 7, 
the stored procedure should display a message that says, 
“The number of products is greater than or equal to 7”. Otherwise, it should say, 
“The number of products is less than 7”. */

DROP PROCEDURE IF EXISTS test;

DELIMITER // 

CREATE PROCEDURE test()
BEGIN
	DECLARE count_all_products INT;
    
    SELECT COUNT(product_id)
	INTO count_all_products
	FROM products;
    
    IF count_all_products >= 7 THEN
		SELECT 'The number of products is greater than or equal to 7' AS message;
	ELSE
		SELECT 'The number of products is less than 7' AS message;
        
	END IF;

END// 

DELIMITER ;

CALL test()



/* Write a script that creates and calls a stored procedure named test. 
This stored procedure should use two variables to store 
(1) the count of all of the products in the Products table and 
(2) the average list price for those products. 
If the product count is greater than or equal to 7, 
the stored procedure should display a result set that displays the values of both variables. 
Otherwise, the procedure should display a result set that displays a message that says, 
“The number of products is less than 7”. */


DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE count_all_products INT;
    DECLARE avg_list_price DECIMAL(9,2);
    
    SELECT COUNT(product_id), AVG(list_price)
    INTO count_all_products, avg_list_price
    FROM products;
    
    IF count_all_products > 7 THEN
		SELECT concat(count_all_products, ',', avg_list_price) AS message;
	ELSE
		SELECT 'The number of products is less than 7' AS message;
	END IF;

END//

DELIMITER ;

CALL test()



/* 3. Write a script that creates and calls a stored procedure named test. 
This procedure should calculate the common factors between 10 and 20. 
To find a common factor, you can use the modulo operator (%) to check 
whether a number can be evenly divided into both numbers. 
Then, this procedure should display a string that displays the common factors like this:

Common factors of 10 and 20: 1 2 5 */

DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE i INT;
    DECLARE factor_10 INT;
    DECLARE factor_20 INT;
    DECLARE common_factor VARCHAR(400) DEFAULT 'Common factors of 10 and 20: ';
    
    SET factor_10 = 10;
    SET factor_20 = 20;
    SET i = 1;
    
    WHILE (i < factor_10) DO
    
    IF (factor_10%i = 0 AND factor_20%i = 0) THEN
		SET common_factor = CONCAT(common_factor, i, ' ');
        END IF;
        SET i = i + 1;
	END WHILE;
    
    SELECT common_factor AS message;
    
END// 

DELIMITER ; 

CALL test()

/* 4. Write a script that creates and calls a stored procedure named test. 
This stored procedure should create a cursor for a result set that consists of the 
product_name and list_price columns for each product with a list price that’s greater than $700. 
The rows in this result set should be sorted in descending sequence by list price. 
Then, the procedure should display a string variable that includes the 
product_name and list price for each product so it looks something like this:

"Gibson SG", "2517.00" | "Gibson Les Paul", "1199.00"

Here, each value is enclosed in double quotes ("), 
each column is separated by a comma (,) and each row is separated by a pipe character (|). */

DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
DECLARE product_name_cursor VARCHAR(50);
DECLARE list_price_cursor DECIMAL(9,2);
DECLARE row_not_found TINYINT DEFAULT FALSE;
DECLARE s_cursor VARCHAR(400) DEFAULT '';
               
	DECLARE product_cursor CURSOR FOR
		SELECT product_name, list_price
		FROM products
		WHERE list_price > 700
		ORDER BY list_price DESC;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;


/* 5. Write a script that creates and calls a stored procedure named test. 
This procedure should attempt to insert a new category named “Guitars” into the Categories table. 
If the insert is successful, the procedure should display this message:

	1 row was inserted.

If the update is unsuccessful, the procedure should display this message:

	Row was not inserted - duplicate entry. */
	
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
DECLARE duplicate_entry TINYINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR 1062
	SET duplicate_entry = TRUE;
    
INSERT INTO categories (category_id, category_name) 
VALUES (DEFAULT,'Guitars');

	IF duplicate_entry = TRUE THEN
		SELECT '1 row was inserted.' AS message;
	ELSE
		SELECT 'Row was not inserted - duplicate entry.' AS message;
END IF;

END//

DELIMITER ;

CALL test();


