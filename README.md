# Kafka-Flink-Clickhouse
Data pipeline involving various DataSources; Kafka, ClickHouse, Airflow, and Apache Flink used.

# Overall Case Study Deliverables (Required)
1. ClickHouse Database and Table Schemas: /Scenario_1/clickhouse-init
2. Airflow DAG Code: igb-public-tools/kafka/airflow/dags/daily_sales_metrics_calculation.py
3. ClickHouse Summarization Table: Scenario_2/clickhouse-schema
4. Pipeline Design & Metrics Calculation Logic: igb-public-tools/kafka/airflow/dags/daily_sales_metrics_calculation.py
5. Flink Installation and Configuration Setup
6. Flink Job Code (pyFlink)
7. Watermarking and Deduplication Logic

# Execution

1. docker compose up
2. python /Scenario_1/init.py (Executes all relevant python files)
3. python /Scenario_2/clickhouse-schema/init.py (Create clickhouse table.)
