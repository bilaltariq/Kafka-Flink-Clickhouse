DROP TABLE IF EXISTS products_kafka;

CREATE TABLE IF NOT EXISTS products_kafka (
    after ROW<
        id BIGINT,
        name STRING,
        description STRING,
        price DOUBLE,
        cost_price DOUBLE,
        created_at TIMESTAMP(3),
        updated_at TIMESTAMP(3)
    >,
    op STRING,
    ts_ms BIGINT,
    cdc_time AS TO_TIMESTAMP_LTZ(ts_ms, 3),
    WATERMARK FOR cdc_time AS cdc_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'demo_db_master.demo.products',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-products-consumer',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'debezium-json'
);

DROP TABLE IF EXISTS orders_kafka;

CREATE TABLE IF NOT EXISTS orders_kafka (
    after ROW<
        id BIGINT,
        customer_name STRING,
        status STRING,
        total_amount DOUBLE,
        created_at TIMESTAMP(3),
        updated_at TIMESTAMP(3)
    >,
    op STRING,
    ts_ms BIGINT,
    cdc_time AS TO_TIMESTAMP_LTZ(ts_ms, 3),
    WATERMARK FOR cdc_time AS cdc_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'demo_db_master.demo.orders',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-orders-consumer',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'debezium-json'
);

DROP TABLE IF EXISTS order_items_kafka;

CREATE TABLE IF NOT EXISTS order_items_kafka (
    after ROW<
        id BIGINT,
        order_id BIGINT,
        product_id BIGINT,
        quantity INT,
        price DOUBLE,
        cost_price DOUBLE,
        created_at TIMESTAMP(3),
        updated_at TIMESTAMP(3)
    >,
    op STRING,
    ts_ms BIGINT,
    cdc_time AS TO_TIMESTAMP_LTZ(ts_ms, 3),
    WATERMARK FOR cdc_time AS cdc_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'demo_db_master.demo.order_items',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-order-items-consumer',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'debezium-json'
);
