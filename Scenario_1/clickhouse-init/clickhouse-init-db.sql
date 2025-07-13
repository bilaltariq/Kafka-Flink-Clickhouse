-- Create databases to logically separate streaming input (Kafka) and final storage (MergeTree)
CREATE DATABASE IF NOT EXISTS kafka_tables;
CREATE DATABASE IF NOT EXISTS demo_tables;