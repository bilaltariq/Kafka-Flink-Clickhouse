-- Create databases to logically separate streaming input (Kafka) and final storage (MergeTree)
DROP DATABASE kafka_tables;
DROP DATABASE demo_tables;

CREATE DATABASE IF NOT EXISTS kafka_tables;
CREATE DATABASE IF NOT EXISTS demo_tables;