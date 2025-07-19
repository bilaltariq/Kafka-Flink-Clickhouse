-- Drop existing Kafka tables if they exist
DROP TABLE IF EXISTS kafka_tables.products_kafka;
DROP TABLE IF EXISTS kafka_tables.orders_kafka;
DROP TABLE IF EXISTS kafka_tables.order_items_kafka;

CREATE TABLE kafka_tables.products_kafka
(
    raw_message String
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.products',
    kafka_group_name = 'products_consumer',
    kafka_format = 'JSONAsString',
    kafka_skip_broken_messages = 1,
    kafka_num_consumers = 1;

CREATE TABLE kafka_tables.orders_kafka
(
    raw_message String
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.orders',
    kafka_group_name = 'clickhouse_consumer',
    kafka_format = 'JSONAsString',
    kafka_skip_broken_messages = 1,
    kafka_num_consumers = 1;

CREATE TABLE kafka_tables.order_items_kafka
(
    raw_message String
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'demo_db_master.demo.order_items',
    kafka_group_name = 'clickhouse_consumer',
    kafka_format = 'JSONAsString',
    kafka_skip_broken_messages = 1,
    kafka_num_consumers = 1;
