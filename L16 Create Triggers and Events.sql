/* 1. Create a trigger named products_before_update that checks the new value for
the discount_percent column of the Products table. This trigger should raise an appropriate 
error if the discount percent is greater than 100 or less than 0.

If the new discount percent is between 0 and 1, this trigger should modify
the new discount percent by multiplying it by 100. That way, a discount percent of .2 becomes 20.

Test this trigger with an appropriate UPDATE statement. */

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



/* 2. Create a trigger named products_before_insert that inserts the 
current date for the date_added column of the Products table if the value for that column is null.

Test this trigger with an appropriate INSERT statement. */

DROP TRIGGER IF EXISTS products_before_insert;

DELIMITER //

CREATE TRIGGER products_before_insert
	BEFORE INSERT ON products
    FOR EACH ROW
BEGIN
	SET new.date_added = NOW();
END//


    INSERT INTO products 
		(
        category_id, 
        product_code, 
        product_name, 
        description, 
        list_price, 
        discount_percent, 
        date_added)
    VALUES 
		(
        4, 
        'Prodcode', 
        'ProductNameTest',
		'Description of product',
		100.00, 
        50.00, 
        NULL)

/* 3. Create a table named Products_Audit. 
This table should have all columns of the Products table, 
except the description column. Also, it should have an audit_id column for its primary key,
and the date_added column should be changed to date_updated.

Create a trigger named products_after_update. This trigger should insert the old data
about the product into the Products_Audit table after the row is updated. Then, test 
this trigger with an appropriate UPDATE statement. */

DROP TABLE IF EXISTS products_audit;

CREATE TABLE products_audit 
(
  audit_id			 INT			PRIMARY KEY	  AUTO_INCREMENT,
  product_id		 INT			NOT NULL,
  category_id        INT            NOT NULL,
  product_code       VARCHAR(10)    NOT NULL      UNIQUE,
  product_name       VARCHAR(255)   NOT NULL,
  list_price         DECIMAL(10,2)  NOT NULL,
  discount_percent   DECIMAL(10,2)  NOT NULL      DEFAULT 0.00,
  date_updated       DATETIME                   DEFAULT NULL,
  CONSTRAINT products_audit_fk_categories
	FOREIGN KEY (product_id) REFERENCES products (product_id),
    FOREIGN KEY (category_id)
    REFERENCES categories (category_id)
);

DROP TRIGGER IF EXISTS products_after_update;

DELIMITER //

CREATE TRIGGER products_after_update
	BEFORE UPDATE ON products
    FOR EACH ROW
BEGIN
	INSERT INTO products_audit 
		(category_id, product_id, product_code, product_name, list_price, discount_percent, date_updated)
	VALUES 
		(OLD.category_id,OLD.product_id, OLD.product_code, OLD.product_name, OLD.list_price, 
		OLD.discount_percent, OLD.date_added);
    
END//

DELIMITER ;

UPDATE products
	set list_price = 799
    WHERE product_id = 1;



/* 4. Check whether the event scheduler is turned on. If it isn’t, code a statement that turns it on.

Create an event that deletes any rows in the Products_Audit table 
that are older than 1 week. (You created the Products_Audit table in exercise 3.) 
MySQL should run this event every day. To make sure that this event has been created, 
code a SHOW EVENTS statement that views this event.

Once you’re sure this event is working correctly, code a DROP EVENT statement that drops the event. */

SHOW VARIABLES LIKE 'event_scheduler';

SHOW EVENTS;

DELIMITER //

CREATE EVENT delete_weekly_audits
ON SCHEDULE EVERY 1 DAY
DO BEGIN
	DELETE FROM products_audit WHERE date_updated < date_added(DAY, -7, sysdate());

END//

DELIMITER ;

DROP EVENT IF EXISTS delete_weekly_audits;


