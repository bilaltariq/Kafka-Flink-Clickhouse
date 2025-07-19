# Scenario 2: ClickHouse + Airflow Challenge

---

# Task 2 - Checklist

## 1. Install Airflow and ClickHouse
- [X] Set up **Apache Airflow** in a local or containerized environment.
- [X] Set up **ClickHouse** as the destination database for daily sales metrics.
- [X] Ensure Airflow handles orchestration and scheduling.

## 2. Daily Sales Metrics Calculation
- [X] Design an Airflow **DAG** that aggregates daily sales metrics.
- [X] Configure DAG to **run every 6 hours**.
- [X] Ensure it:
  - [X] Aggregates metrics only for the **current day**.
  - [X] Reprocesses data for updated rows.
  - [] Prevents **duplicate entries** for the same day.

## 3. ClickHouse Table for Storing Metrics
- [X] Table name: `daily_sales_stats`
- [] Use appropriate **table engine** for time-series metrics: consider `AggregatingMergeTree`
- [ ] Define the following columns:
  - [X] `date Date` – Date of the metric aggregation.
  - [X] `total_orders UInt32` – Total completed orders.
  - [X] `total_items_sold UInt32` – Quantity sold across orders.
  - [X] `total_revenue Decimal(15, 2)` – Revenue = `price * quantity`.
  - [X] `total_cost Decimal(15, 2)` – Cost = `cost_price * quantity`.
  - [X] `total_profit Decimal(15, 2)` – Profit = `total_revenue - total_cost`.
  - [X] `average_order_value Decimal(15, 2)` – AOV = `total_revenue / total_orders`.

## 4. Pipeline Design
- [ ] Extract data from:
  - [X] `orders` table.
  - [X] `order_items` table.
- [X] Calculate metrics using **SQL + Python** in the Airflow DAG.
- [X] Store results in `daily_sales_stats` table in ClickHouse.
- [X] Replace existing values for the **current date** if already present.

## 5. Recalculation Logic
- [X] Ensure DAG reruns every **6 hours** to capture:
  - [X] New data entries.
  - [X] Updated data entries for the same day.
- [ ] Prevent duplicate rows unless the underlying data was updated.

## 6. Testing and Validation
- [X] Manually trigger the DAG to validate behavior.
- [ ] Check ClickHouse for:
  - [ ] Accurate `total_orders`.
  - [ ] Correct `total_revenue`.
  - [ ] Correct `total_cost`.
  - [ ] Correct `total_profit`.
  - [ ] Correct `average_order_value`.

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
