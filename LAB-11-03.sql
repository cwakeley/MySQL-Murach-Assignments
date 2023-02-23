INSERT INTO users
VALUES 
	(default, 'Johnsmith@gmail.com', 'John', 'Smith'),
	(default, 'Janedoe@gmail.com', 'Jane', 'Doe');
    
INSERT INTO products
VALUES 
	(default, 'Local Music Vol 1'),
    (default, 'Local Music Vol 2');
    
INSERT INTO downloads
VALUES 
	(default, 1, NOW(), 'pedals_are_falling.mp3', 2),
    (default, 2, NOW(), 'turn_signal.mp3', 1),
    (default, 2, NOW(), 'one_horse_town.mp3', 2);
    
SELECT 
	u.email_address, u.first_name, u.last_name, d.download_date,
    d.filename, p.product_name
FROM downloads AS d
	JOIN users AS u
		ON u.user_id = d.user_id
	JOIN products AS p
		ON p.product_id = d.product_id
ORDER BY u.email_address DESC, p.product_name ASC;
	