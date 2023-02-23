/* 1. Write a SQL script that adds an index to the my_guitar_shop database for the last_name field in the Customers table. */

CREATE INDEX last_name_ix
	ON CUSTOMERS (last_name);



/* 2. Write a script that implements the following design in a database named my_web_db: 

	In the Downloads table, the user_id and product_id columns are the foreign keys. 
		Include a statement to drop the database if it already exists.
	Include statements to create and select the database.
	Include any indexes that you think are necessary.
	Specify the utf8 character set for all tables.
	Specify the InnoDB storage engine for all tables. */


DROP DATABASE IF EXISTS my_web_db;
CREATE DATABASE my_web_db;

USE my_web_db;

CREATE TABLE users
(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email_address VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(45) NOT NULL ,
    last_name VARCHAR(45) NOT NULL
)
CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
ENGINE = InnoDB;

CREATE TABLE downloads
(
	download_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT NOT NULL,
	download_date DATE NOT NULL,
	filename VARCHAR(50) NOT NULL,
	product_id INT NOT NULL,
	CONSTRAINT user_id_FK 
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	CONSTRAINT product_id_FK
	FOREIGN KEY (product_id) REFERENCES products (product_id)
)

CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
ENGINE = InnoDB;


CREATE TABLE products
(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
	product_name VARCHAR(45) NOT NULL
)
CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
ENGINE = InnoDB



/* 3. Write a script that performs the following three activities on the database that you created in problem 2.

	Add two rows to the Users and Products tables.
	Add three rows to the Downloads table: one row for user 1 and product 2; one row for user 2 and product 1; 
	and one row for user 2 and product 2. Use the NOW function to insert the current date and time into the download_date column.
	Write a SELECT statement that joins the three tables and retrieves the data from these tables like this: 

Sort the results by the email address in descending sequence and the product name in ascending sequence. */

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



/* 4. 	
Write a script that contains an ALTER TABLE statement that adds two new columns to the Products table created in problem 2. 

	Add one column for product price that provides for three digits to the left of the decimal point and two to the right. 
		This column should have a default value of 9.99.
	Add one column for the date and time that the product was added to the database. */
	
ALTER TABLE products
ADD 
	(product_price DECIMAL(5,2) NOT NULL DEFAULT(9.99),
	date_added DATETIME NOT NULL);
	


/* 5. Write a script that contains an ALTER TABLE statement that modifies the 
Users table created in problem 2 so the first_name column cannot store NULL values 
and can store a maximum of 20 characters. */

ALTER TABLE users
MODIFY first_name VARCHAR(20) NOT NULL
