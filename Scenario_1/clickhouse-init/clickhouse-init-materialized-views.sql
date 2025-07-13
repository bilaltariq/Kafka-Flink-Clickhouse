-- Materialized view for products
CREATE MATERIALIZED VIEW IF NOT EXISTS default.mv_products
TO demo_tables.products
AS
SELECT
    id,
    name,
    description,
    price,
    cost_price,
    created_at,
    updated_at,
    kafka_timestamp
FROM kafka_tables.products_kafka;

-- Materialized view for orders
CREATE MATERIALIZED VIEW IF NOT EXISTS default.mv_orders
TO demo_tables.orders
AS
SELECT
    id,
    customer_name,
    status,
    total_amount,
    created_at,
    updated_at,
    kafka_timestamp
FROM kafka_tables.orders_kafka;

-- Materialized view for order_items
CREATE MATERIALIZED VIEW IF NOT EXISTS default.mv_order_items
TO demo_tables.order_items
AS
SELECT
    id,
    order_id,
    product_id,
    quantity,
    price,
    cost_price,
    created_at,
    updated_at,
    kafka_timestamp
FROM kafka_tables.order_items_kafka;
