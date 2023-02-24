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
    
    