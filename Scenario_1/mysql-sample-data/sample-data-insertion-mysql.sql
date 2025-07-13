
USE demo;

INSERT INTO products (name, description, price, cost_price)
VALUES
('Product 1', 'Sample product 1', 10.00, 6.00),
('Product 2', 'Sample product 2', 12.50, 8.00),
('Product 3', 'Sample product 3', 8.99, 5.00),
('Product 4', 'Sample product 4', 15.99, 10.00),
('Product 5', 'Sample product 5', 6.50, 3.00),
('Product 6', 'Sample product 6', 20.00, 12.00),
('Product 7', 'Sample product 7', 14.75, 9.00),
('Product 8', 'Sample product 8', 11.00, 7.00),
('Product 9', 'Sample product 9', 7.25, 4.50),
('Product 10', 'Sample product 10', 13.50, 9.50),
('Product 11', 'Sample product 11', 9.99, 6.00),
('Product 12', 'Sample product 12', 16.75, 10.00),
('Product 13', 'Sample product 13', 19.00, 14.00),
('Product 14', 'Sample product 14', 5.99, 3.00),
('Product 15', 'Sample product 15', 18.50, 11.00),
('Product 16', 'Sample product 16', 10.50, 6.50),
('Product 17', 'Sample product 17', 7.75, 4.75),
('Product 18', 'Sample product 18', 22.00, 15.00),
('Product 19', 'Sample product 19', 6.25, 3.75),
('Product 20', 'Sample product 20', 21.50, 14.50),
('Product 21', 'Sample product 21', 17.00, 11.50),
('Product 22', 'Sample product 22', 23.00, 16.00),
('Product 23', 'Sample product 23', 8.25, 5.25),
('Product 24', 'Sample product 24', 9.50, 6.25),
('Product 25', 'Sample product 25', 12.00, 8.00),
('Product 26', 'Sample product 26', 11.75, 7.75),
('Product 27', 'Sample product 27', 13.99, 9.99),
('Product 28', 'Sample product 28', 18.25, 12.25),
('Product 29', 'Sample product 29', 24.99, 18.00),
('Product 30', 'Sample product 30', 5.50, 3.00);

COMMIT;

-- Insert 10 sample orders
INSERT INTO orders (customer_name, status, total_amount)
VALUES
('Alice Johnson', 'completed', 56.75),
('Bob Williams', 'pending', 43.50),
('Charlie Brown', 'completed', 71.99),
('Diana Prince', 'canceled', 35.00),
('Ethan Hunt', 'pending', 60.25),
('Fiona Gallagher', 'completed', 84.90),
('George Orwell', 'completed', 42.75),
('Helen Mirren', 'pending', 29.99),
('Ian Fleming', 'completed', 65.50),
('Jack Sparrow', 'pending', 31.49);

COMMIT;

-- Insert ~50 order items (random selection of products and quantities)
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES
(1, 2, 2, 12.50, 8.00),
(1, 5, 1, 6.50, 3.00),
(1, 8, 1, 11.00, 7.00),
(2, 3, 3, 8.99, 5.00),
(2, 6, 1, 20.00, 12.00),
(2, 10, 2, 13.50, 9.50),
(3, 1, 2, 10.00, 6.00),
(3, 7, 1, 14.75, 9.00),
(3, 12, 1, 16.75, 10.00),
(3, 15, 2, 18.50, 11.00),
(4, 4, 1, 15.99, 10.00),
(4, 14, 1, 5.99, 3.00),
(5, 18, 2, 22.00, 15.00),
(5, 20, 1, 21.50, 14.50),
(5, 25, 1, 12.00, 8.00),
(6, 9, 2, 7.25, 4.50),
(6, 16, 1, 10.50, 6.50),
(6, 22, 2, 23.00, 16.00),
(7, 11, 1, 9.99, 6.00),
(7, 13, 1, 19.00, 14.00),
(7, 19, 1, 6.25, 3.75),
(8, 17, 2, 7.75, 4.75),
(8, 24, 1, 9.50, 6.25),
(9, 21, 1, 17.00, 11.50),
(9, 26, 2, 11.75, 7.75),
(9, 28, 1, 18.25, 12.25),
(10, 23, 1, 8.25, 5.25),
(10, 29, 1, 24.99, 18.00),
(10, 30, 2, 5.50, 3.00),
(2, 27, 1, 13.99, 9.99),
(6, 17, 1, 7.75, 4.75),
(5, 21, 1, 17.00, 11.50),
(7, 24, 2, 9.50, 6.25),
(8, 12, 1, 16.75, 10.00),
(3, 16, 1, 10.50, 6.50),
(1, 13, 1, 19.00, 14.00),
(9, 6, 1, 20.00, 12.00),
(4, 18, 1, 22.00, 15.00),
(4, 22, 1, 23.00, 16.00),
(10, 1, 1, 10.00, 6.00),
(2, 28, 1, 18.25, 12.25),
(7, 7, 1, 14.75, 9.00),
(3, 19, 2, 6.25, 3.75),
(5, 10, 1, 13.50, 9.50),
(6, 2, 1, 12.50, 8.00),
(8, 5, 1, 6.50, 3.00),
(9, 9, 1, 7.25, 4.50),
(10, 14, 1, 5.99, 3.00),
(1, 4, 1, 15.99, 10.00),
(6, 8, 2, 11.00, 7.00);

COMMIT;
