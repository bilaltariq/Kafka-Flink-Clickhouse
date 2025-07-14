-- Drop MVs if already exist
DROP TABLE IF EXISTS default.mv_products;
DROP TABLE IF EXISTS default.mv_orders;
DROP TABLE IF EXISTS default.mv_order_items;

-- CREATE MATERIALIZED VIEW default.mv_products
-- TO demo_tables.products
-- AS
-- SELECT
--     toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'id', 'UInt64')) AS id,
--     JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'name') AS name,
--     JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'description') AS description,
--     toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'price', 'Float64')) AS price,
--     toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'cost_price', 'Float64')) AS cost_price,
--     ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.created_at')), now()) AS created_at,
--     ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.updated_at')), now()) AS updated_at
-- FROM kafka_tables.products_kafka;

CREATE MATERIALIZED VIEW default.mv_products
TO demo_tables.products
AS
SELECT
    toUInt64(JSONExtract(after_raw, 'id', 'UInt64')) AS id,
    JSONExtractString(after_raw, 'name') AS name,
    JSONExtractString(after_raw, 'description') AS description,
    toFloat64(JSONExtract(after_raw, 'price', 'Float64')) AS price,
    toFloat64(JSONExtract(after_raw, 'cost_price', 'Float64')) AS cost_price,
    toDateTime(JSONExtract(after_raw, 'created_at', 'UInt64') / 1000) AS created_at,
    toDateTime(JSONExtract(after_raw, 'updated_at', 'UInt64') / 1000) AS updated_at
FROM (
    SELECT
        JSONExtractRaw(raw_message, 'after') AS after_raw
    FROM kafka_tables.products_kafka
);


CREATE MATERIALIZED VIEW default.mv_orders
TO demo_tables.orders
AS
SELECT
    toUInt64(JSONExtract(raw_message, 'after.id', 'UInt64')) AS id,
    JSONExtractString(raw_message, 'after.customer_name') AS customer_name,
    JSONExtractString(raw_message, 'after.status') AS status,
    toFloat64(JSONExtract(raw_message, 'after.total_amount', 'Float64')) AS total_amount,
    ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.created_at')), now()) AS created_at,
    ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.updated_at')), now()) AS updated_at
FROM kafka_tables.orders_kafka;


CREATE MATERIALIZED VIEW default.mv_order_items
TO demo_tables.order_items
AS
SELECT
    toUInt64(JSONExtract(raw_message, 'after.id', 'UInt64')) AS id,
    toUInt64(JSONExtract(raw_message, 'after.order_id', 'UInt64')) AS order_id,
    toUInt64(JSONExtract(raw_message, 'after.product_id', 'UInt64')) AS product_id,
    toUInt32(JSONExtract(raw_message, 'after.quantity', 'UInt32')) AS quantity,
    toFloat64(JSONExtract(raw_message, 'after.price', 'Float64')) AS price,
    toFloat64(JSONExtract(raw_message, 'after.cost_price', 'Float64')) AS cost_price,
    ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.created_at')), now()) AS created_at,
    ifNull(parseDateTimeBestEffortOrNull(JSONExtractString(raw_message, 'after.updated_at')), now()) AS updated_at
FROM kafka_tables.order_items_kafka;
