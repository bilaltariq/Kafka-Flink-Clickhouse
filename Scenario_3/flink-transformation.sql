
INSERT INTO products_ch
SELECT 
    after.id,
    after.name,
    after.description,
    after.price,
    after.cost_price,
    after.created_at,
    after.updated_at
FROM products_kafka
WHERE op = 'c';

INSERT INTO orders_ch
SELECT 
    after.id,
    after.customer_name,
    after.status,
    after.total_amount,
    after.created_at,
    after.updated_at
FROM orders_kafka
WHERE op = 'c';


INSERT INTO order_items_ch
SELECT 
    after.id,
    after.order_id,
    after.product_id,
    after.quantity,
    after.price,
    after.cost_price,
    after.created_at,
    after.updated_at
FROM order_items_kafka
WHERE op = 'c';
