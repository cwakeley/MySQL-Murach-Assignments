/*Create*/
DROP DATABASE IF EXISTS my_web_db;
CREATE DATABASE my_web_db;

/* Select database*/
USE my_web_db;

/* Create tables */
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


    
