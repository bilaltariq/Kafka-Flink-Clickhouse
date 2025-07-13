-- Kafka table for products
CREATE TABLE IF NOT EXISTS kafka_tables.products_kafka
(
    id Int32,
    name String,
    description String,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.products',
    kafka_group_name = 'clickhouse_consumer',
    kafka_format = 'JSONEachRow';


-- Kafka table for orders
CREATE TABLE IF NOT EXISTS kafka_tables.orders_kafka
(
    id Int32,
    customer_name String,
    status String,
    total_amount Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.orders',
    kafka_group_name = 'clickhouse_consumer',
    kafka_format = 'JSONEachRow';


-- Kafka table for order_items
CREATE TABLE IF NOT EXISTS kafka_tables.order_items_kafka
(
    id Int32,
    order_id Int32,
    product_id Int32,
    quantity Int32,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.order_items',
    kafka_group_name = 'clickhouse_consumer',
    kafka_format = 'JSONEachRow';
