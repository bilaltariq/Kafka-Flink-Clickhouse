# Scenario 2: ClickHouse + Airflow Challenge

---

# Deliverables

- ClickHouse setup in local environment using Docker
- Airflow setup with Docker using official Helm chart and `docker-compose`
- Table creation script and schema loaded into ClickHouse
- DAG created in Airflow to orchestrate daily metric ingestion into ClickHouse
- Schema for `demo_tables.daily_sales_stats` using `ReplacingMergeTree`
- Python script to verify successful table creation
- Verified metrics ingestion via DAG and validated through ClickHouse client

---

# Task 2 - Checklist

- [x] Install and configure ClickHouse
- [x] Install and configure Apache Airflow
- [x] Create schema and tables in ClickHouse
- [x] Develop Airflow DAG for daily metric ingestion
- [x] Validate metrics loaded successfully
- [x] Implement error handling and table validation script
- [x] Verify system orchestration and end-to-end pipeline execution

---

### Challenges and Solutions

---

**1. Docker Configuration Conflicts**

- *Challenge*: ClickHouse container port conflicts or resource limits on some systems  
- *Solution*: Used custom Docker network and port mapping; fine-tuned resource limits

**2. Schema Execution Failures**

- *Challenge*: Complex `CREATE TABLE` scripts failing silently or partially  
- *Solution*: Used regex-based parser to identify and log failing statements; added retry and error logging

**3. Airflow Connection Issues with ClickHouse**

- *Challenge*: Airflow not connecting to ClickHouse due to missing drivers  
- *Solution*: Installed the `clickhouse-connect` Python package and configured Airflow to use custom hook/operator

**4. DAG Not Reflecting in Airflow UI**

- *Challenge*: DAG not showing up in UI due to syntax errors or placement  
- *Solution*: Validated DAG folder path, restarted scheduler, fixed DAG syntax and ensured Airflow environment variables were set

---

### Summary of Optimization Benefits

---

- **Performance Gains**: ClickHouse's `ReplacingMergeTree` enabled fast upserts and optimized storage for time-series data
- **Storage Efficiency**: Partitioning by `toYYYYMM(date)` helped reduce I/O and improved query speed
- **Orchestration Improvements**: Daily data pipeline automated via Airflow reduced manual intervention and improved consistency
- **Robust Error Handling**: Regex matching for schema execution provided visibility into partial failures
- **Quick Validation**: Table validation logic confirmed setup before triggering ingestion, avoiding silent runtime errors

---

### Future Recommendations

---

- Implement monitoring tools like Grafana or Superset for ClickHouse metric visualization
- Use Airflow’s TaskFlow API for clearer DAG logic and modular Python code
- Explore `AggregatingMergeTree` for more efficient aggregations at insert time
- Scale Airflow with CeleryExecutor and ClickHouse with replication for HA setup
- Integrate alerting (e.g., email or Slack) in DAG on failures
