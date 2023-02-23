ALTER TABLE products
ADD 
	(product_price DECIMAL(5,2) NOT NULL DEFAULT(9.99),
	date_added DATETIME NOT NULL);