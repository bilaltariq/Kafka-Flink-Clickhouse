-- Drop old MVs if they exist
DROP TABLE IF EXISTS default.kafka_to_products;
DROP TABLE IF EXISTS default.kafka_to_orders;
DROP TABLE IF EXISTS default.kafka_to_order_items;

-- Products MV
CREATE MATERIALIZED VIEW default.kafka_to_products
TO demo_tables.products AS
SELECT
    toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'id', 'UInt64')) AS id,
    JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'name') AS name,
    JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'description') AS description,
    toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'price', 'Float64')) AS price,
    toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'cost_price', 'Float64')) AS cost_price,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'updated_at')) AS updated_at,
    JSONExtractString(raw_message, 'op') AS operation,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS cdc_timestamp
FROM kafka_tables.products_kafka;

-- Orders MV
CREATE MATERIALIZED VIEW default.kafka_to_orders
TO demo_tables.orders AS
SELECT
    toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'id', 'UInt64')) AS id,
    JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'customer_name') AS customer_name,
    JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'status') AS status,
    toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'total_amount', 'Float64')) AS total_amount,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'updated_at')) AS updated_at,
    JSONExtractString(raw_message, 'op') AS operation,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS cdc_timestamp
FROM kafka_tables.orders_kafka;

-- Order Items MV
CREATE MATERIALIZED VIEW default.kafka_to_order_items
TO demo_tables.order_items AS
SELECT
    toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'id', 'UInt64')) AS id,
    toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'order_id', 'UInt64')) AS order_id,
    toUInt64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'product_id', 'UInt64')) AS product_id,
    toUInt32(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'quantity', 'UInt32')) AS quantity,
    toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'price', 'Float64')) AS price,
    toFloat64(JSONExtract(JSONExtractRaw(raw_message, 'after'), 'cost_price', 'Float64')) AS cost_price,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'created_at')) AS created_at,
    parseDateTimeBestEffort(JSONExtractString(JSONExtractRaw(raw_message, 'after'), 'updated_at')) AS updated_at,
    JSONExtractString(raw_message, 'op') AS operation,
    toDateTime(JSONExtractUInt(raw_message, 'ts_ms') / 1000) AS cdc_timestamp
FROM kafka_tables.order_items_kafka;
