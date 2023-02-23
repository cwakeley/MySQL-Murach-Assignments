DROP TRIGGER IF EXISTS products_before_update;

DELIMITER //

CREATE TRIGGER products_before_update
BEFORE UPDATE ON products
FOR EACH ROW
	BEGIN
		DECLARE discount_percent_amount INT;
        
	SELECT discount_percent
    INTO discount_percent_amount
    FROM products
    WHERE product_id = new.product_id;
    
    IF new.discount_percent > 100 THEN
		SIGNAL SQLSTATE 'HY000'
			SET message_text = 'the discount cannot be greater than 100';
	ELSEIF new.discount_percent < 0 THEN
		SIGNAL SQLSTATE 'HY000'
			SET message_text = 'the discount cannot be less than 0';
	ELSEIF new.discount_percent < 1 THEN
		SET new.discount_percent = (new.discount_percent * 100);
	
    END IF;
	END//
    
DELIMITER ;

UPDATE products 
SET discount_percent = 101
WHERE product_id = 4;

UPDATE products 
SET discount_percent = 99
WHERE product_id = 4;

    