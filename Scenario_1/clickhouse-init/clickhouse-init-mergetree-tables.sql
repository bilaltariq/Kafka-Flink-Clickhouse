-- Drop and recreate final table for products
DROP TABLE IF EXISTS demo_tables.products;

CREATE TABLE demo_tables.products
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

-- Drop and recreate final table for orders
DROP TABLE IF EXISTS demo_tables.orders;

CREATE TABLE demo_tables.orders
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

-- Drop and recreate final table for order_items
DROP TABLE IF EXISTS demo_tables.order_items;

CREATE TABLE demo_tables.order_items
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
