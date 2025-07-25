DROP TABLE IF EXISTS demo_tables.daily_sales_stats;

CREATE TABLE IF NOT EXISTS demo_tables.daily_sales_stats
(
    date Date,
    total_orders UInt32,
    total_items_sold UInt32,
    total_revenue Decimal(15, 2),
    total_cost Decimal(15, 2),
    total_profit Decimal(15, 2),
    average_order_value Decimal(15, 2)
)
ENGINE = ReplacingMergeTree()
PARTITION BY toYYYYMM(date)
ORDER BY (date);
