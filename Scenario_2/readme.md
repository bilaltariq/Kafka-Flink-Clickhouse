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
- [X] Use appropriate **table engine** for time-series metrics: consider `AggregatingMergeTree` =>Used ReplacingMergeTree
- [X] Define the following columns:
  - [X] `date Date` – Date of the metric aggregation.
  - [X] `total_orders UInt32` – Total completed orders.
  - [X] `total_items_sold UInt32` – Quantity sold across orders.
  - [X] `total_revenue Decimal(15, 2)` – Revenue = `price * quantity`.
  - [X] `total_cost Decimal(15, 2)` – Cost = `cost_price * quantity`.
  - [X] `total_profit Decimal(15, 2)` – Profit = `total_revenue - total_cost`.
  - [X] `average_order_value Decimal(15, 2)` – AOV = `total_revenue / total_orders`.

## 4. Pipeline Design
- [X] Extract data from:
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
- [X] Check ClickHouse for:
  - [X] Accurate `total_orders`.
  - [X] Correct `total_revenue`.
  - [X] Correct `total_cost`.
  - [X] Correct `total_profit`.
  - [X] Correct `average_order_value`.

---

### Challenges and Solutions

---
 
- No as such.

---

### Summary of Optimization Benefits

---

- **Performance Gains**: ClickHouse's `ReplacingMergeTree` enabled fast upserts and optimized storage for time-series data
- **Storage Efficiency**: Partitioning by `toYYYYMM(date)` helped reduce I/O and improved query speed
- **Orchestration Improvements**: Daily data pipeline automated via Airflow reduced manual intervention and improved consistency

---

### Future Recommendations

---

- Explore `AggregatingMergeTree` for more efficient aggregations at insert time