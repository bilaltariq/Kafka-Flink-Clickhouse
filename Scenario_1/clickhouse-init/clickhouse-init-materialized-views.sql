-- Drop materialized views if they exist
DROP TABLE IF EXISTS default.mv_products;
DROP TABLE IF EXISTS default.mv_orders;
DROP TABLE IF EXISTS default.mv_order_items;

-- === Materialized View: Products ===
CREATE MATERIALIZED VIEW default.mv_products
TO demo_tables.products
AS
SELECT
    JSONExtractInt(raw_message, 'after.id') AS id,
    JSONExtractString(raw_message, 'after.name') AS name,
    JSONExtractString(raw_message, 'after.description') AS description,
    JSONExtractFloat(raw_message, 'after.price') AS price,
    JSONExtractFloat(raw_message, 'after.cost_price') AS cost_price,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.updated_at')) AS updated_at,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS kafka_timestamp
FROM kafka_tables.products_kafka;

-- === Materialized View: Orders ===
CREATE MATERIALIZED VIEW default.mv_orders
TO demo_tables.orders
AS
SELECT
    JSONExtractInt(raw_message, 'after.id') AS id,
    JSONExtractString(raw_message, 'after.customer_name') AS customer_name,
    JSONExtractString(raw_message, 'after.status') AS status,
    JSONExtractFloat(raw_message, 'after.total_amount') AS total_amount,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.updated_at')) AS updated_at,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS kafka_timestamp
FROM kafka_tables.orders_kafka;

-- === Materialized View: Order Items ===
CREATE MATERIALIZED VIEW default.mv_order_items
TO demo_tables.order_items
AS
SELECT
    JSONExtractInt(raw_message, 'after.id') AS id,
    JSONExtractInt(raw_message, 'after.order_id') AS order_id,
    JSONExtractInt(raw_message, 'after.product_id') AS product_id,
    JSONExtractInt(raw_message, 'after.quantity') AS quantity,
    JSONExtractFloat(raw_message, 'after.price') AS price,
    JSONExtractFloat(raw_message, 'after.cost_price') AS cost_price,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(raw_message, 'after.updated_at')) AS updated_at,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS kafka_timestamp
FROM kafka_tables.order_items_kafka;
