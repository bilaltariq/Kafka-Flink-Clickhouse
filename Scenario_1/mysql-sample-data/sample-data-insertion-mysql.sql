-- Products
INSERT INTO products (name, description, price, cost_price) VALUES ('Product 1', 'Sample product 1', 10.00, 6.00);
INSERT INTO products (name, description, price, cost_price) VALUES ('Product 2', 'Sample product 2', 12.50, 8.00);
INSERT INTO products (name, description, price, cost_price) VALUES ('Product 3', 'Sample product 3', 8.99, 5.00);
INSERT INTO products (name, description, price, cost_price) VALUES ('Product 4', 'Sample product 4', 15.99, 10.00);
INSERT INTO products (name, description, price, cost_price) VALUES ('Product 5', 'Sample product 5', 6.50, 3.00);

COMMIT;

-- Orders
INSERT INTO orders (customer_name, status, total_amount) VALUES ('Alice Johnson', 'completed', 40.99);
INSERT INTO orders (customer_name, status, total_amount) VALUES ('Bob Williams', 'pending', 33.99);
INSERT INTO orders (customer_name, status, total_amount) VALUES ('Charlie Brown', 'completed', 28.99);

COMMIT;

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (1, 1, 2, 10.00, 6.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (1, 2, 1, 12.50, 8.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (1, 5, 1, 6.50, 3.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (2, 3, 2, 8.99, 5.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (2, 4, 1, 15.99, 10.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (2, 5, 1, 6.50, 3.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (3, 1, 1, 10.00, 6.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (3, 2, 1, 12.50, 8.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (3, 3, 1, 8.99, 5.00);
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES (3, 4, 1, 15.99, 10.00);

COMMIT;
