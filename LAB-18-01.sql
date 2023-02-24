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