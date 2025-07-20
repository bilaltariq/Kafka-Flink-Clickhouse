# Kafka-Flink-Clickhouse
Data pipeline involving various DataSources; Kafka, ClickHouse, Airflow, and Apache Flink used.

# Overall Case Study Deliverables (Required)
1. ClickHouse Database and Table Schemas: **/Scenario_1/clickhouse-init**
2. Airflow DAG Code: **igb-public-tools/kafka/airflow/dags/daily_sales_metrics_calculation.py**
3. ClickHouse Summarization Table: **Scenario_2/clickhouse-schema**
4. Pipeline Design & Metrics Calculation Logic: **igb-public-tools/kafka/airflow/dags/daily_sales_metrics_calculation.py**
5. Flink Installation and Configuration Setup: **docker-compose.yml;/flink-jobs/create-kafka-flink-tables.py** 
6. Flink Job Code (pyFlink): **Not Complete**
7. Watermarking and Deduplication Logic **Not Complete**

# Execution

1. docker compose up
2. python /Scenario_1/init.py (Executes all relevant python files)
3. python /Scenario_2/clickhouse-schema/init.py (Create clickhouse table.)


# Notes
1. Scenario 1 and 2 are complete. A readme.md within each scenario folder is available which has challenges, checklist and improvements.
2. Scenario 3 is partially complete. I am able to setup Flink via docker, it is also communicating b/w Resource and Task manager, however I could not develop the pipeline from Kafka->Flink->Clickhouse. [Time constraints.]