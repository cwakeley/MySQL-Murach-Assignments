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
