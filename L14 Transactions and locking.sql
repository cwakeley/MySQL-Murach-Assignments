/* 1. Write a script that creates and calls a stored procedure named test. This procedure should include two SQL statements coded as a transaction to delete the row with a customer ID of 8 from the Customers table. To do this, you must first delete all addresses for that order from the Addresses table.

If these statements execute successfully, commit the changes. Otherwise, roll back the changes. */


DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    START TRANSACTION;
    
    DELETE FROM addresses WHERE customer_id = 8;
    
    DELETE FROM customers WHERE customer_id = 8;
    
    IF sql_error = FALSE THEN
       COMMIT;
         SELECT 'Transaction Committed' AS msg;
   ELSE
        ROLLBACK;
        SELECT 'Transaction rollbacked' AS msg;
	END IF;
END//

delimiter ;

call test();
    


/* 2. Write a script that creates and calls a stored procedure named test. 
This procedure should include these statements coded as a transaction:

		INSERT INTO orders VALUES
		(DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,
		'American Express', '378282246310005', '04/2013', 4);

		SELECT LAST_INSERT_ID()
		INTO order_id;

		INSERT INTO order_items VALUES
		(DEFAULT, order_id, 6, '415.00', '161.85', 1);

		INSERT INTO order_items VALUES
		(DEFAULT, order_id, 1, '699.00', '209.70', 1);

Here, the LAST_INSERT_ID function is used to get the order ID value that’s 
automatically generated when the first INSERT statement inserts an order.
If these statements execute successfully, commit the changes. Otherwise, roll back the changes. */

DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE order_id INT(11);
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    INSERT INTO orders 
    VALUES
		(DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,
		'American Express', '378282246310005', '04/2013', 4);
	
	SELECT LAST_INSERT_ID() INTO order_id;

	INSERT INTO order_items 
	VALUES
		(DEFAULT, order_id, 6, '415.00', '161.85', 1);

	INSERT INTO order_items 
	VALUES 
		(DEFAULT, order_id, 1, '699.00', '209.70', 1);
        
	IF sql_error = FALSE THEN
       COMMIT;
			SELECT 'Transaction Committed' AS msg;
   ELSE
        ROLLBACK;
			SELECT 'Transaction rollbacked' AS msg;
	END IF;
END//

delimiter ;

call test();
