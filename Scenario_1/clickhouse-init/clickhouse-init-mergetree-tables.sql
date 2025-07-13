-- Final table for products
CREATE TABLE IF NOT EXISTS demo_tables.products
(
    id Int32,
    name String,
    description String,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime DEFAULT now()
)
ENGINE = MergeTree()
ORDER BY id;

-- Final table for orders
CREATE TABLE IF NOT EXISTS demo_tables.orders
(
    id Int32,
    customer_name String,
    status String,
    total_amount Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime DEFAULT now()
)
ENGINE = MergeTree()
ORDER BY id;

-- Final table for order_items
CREATE TABLE IF NOT EXISTS demo_tables.order_items
(
    id Int32,
    order_id Int32,
    product_id Int32,
    quantity Int32,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime,
    kafka_timestamp DateTime DEFAULT now()
)
ENGINE = MergeTree()
ORDER BY id;
