INSERT INTO orders (order_id, order_date) VALUES (1, today()), (2, today());

-- Sample order items
INSERT INTO order_items (order_id, product_id, quantity, price, cost_price) VALUES
(1, 101, 2, 100.00, 70.00),
(1, 102, 1, 150.00, 100.00),
(2, 103, 3, 50.00, 30.00);
