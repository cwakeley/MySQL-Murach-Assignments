/* 1. Connect as the root user and create a script to perform the following tasks:

      Create a user with username and password of your choice.  
                This user should be able to connect to the MySQL database from any computer.
                
      This user should have SELECT, INSERT, UPDATE, and DELETE privileges for the 
                Customers, 
                Addresses, 
                Orders, and 
                Order_Items tables of the My Guitar Shop database.
                However, this user should only have SELECT privileges for the Products and Categories tables. 
                Also, this user should not have the right to grant privileges to other users.
                
      Show the users privileges through the use of the SHOW GRANTS statement.
      Revoke the DELETE privilege on the orders and Order_Items table from this user. */ 

CREATE USER user_chris IDENTIFIED BY 'password';

GRANT SELECT, INSERT, UPDATE, DELETE ON customers TO user_chris;
GRANT SELECT, INSERT, UPDATE, DELETE ON addresses TO user_chris;
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO user_chris;
GRANT SELECT, INSERT, UPDATE, DELETE ON order_items TO user_chris;
GRANT SELECT ON products TO user_chris;
GRANT SELECT ON categories TO user_chris;
SHOW GRANTS FOR user_chris;

REVOKE DELETE ON orders FROM user_chris;
REVOKE DELETE ON order_items FROM user_chris;



/* 2. Connect as the user that was created in Problem 1 and perform the following two activities.  
In your script file insert comments to indicate whether the statements succeed or fail.

          SELECT statement that selects the product_id column for all rows in the Products table
          DELETE statement that attempts to delete one of the rows in the Products table. */
          
/* Statement Succeeded*/ 
SELECT product_id FROM products;

/* Statement failed*/
DELETE FROM products WHERE product_id = '1';

/* 3. Connect as the root user and create a script to perform the following tasks:
              Create another user with username and password of your choice.  
              This user should only be able to connect from the same computer as 
              the computer that's running the MySQL database.
              
              This user should have SELECT and INSERT privileges on all tables in the My Guitar Shop database. 
              However, this user should not have UPDATE or DELETE privileges on this database.
              
              This user should have SELECT and INSERT privileges on all tables in the My Guitar Shop database. 
              However, this user should not have UPDATE or DELETE privileges on this database. */
              
CREATE USER user_mark@localhost IDENTIFIED BY 'password2';

GRANT SELECT, INSERT 
ON my_guitar_shop.*
TO user_mark@localhost;

REVOKE UPDATE, DELETE
ON my_guitar_shop.*
FROM user_mark@localhost;

SHOW GRANTS FOR user_mark@localhost;
             
              
             
              
