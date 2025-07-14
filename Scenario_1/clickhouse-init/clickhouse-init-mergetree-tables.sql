DROP TABLE IF EXISTS demo_tables.products;
DROP TABLE IF EXISTS demo_tables.orders;
DROP TABLE IF EXISTS demo_tables.order_items;

CREATE TABLE demo_tables.products
(
    id UInt64,
    name String,
    description String,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime
)
ENGINE = MergeTree()
ORDER BY id;

CREATE TABLE demo_tables.orders
(
    id UInt64,
    customer_name String,
    status String,
    total_amount Float64,
    created_at DateTime,
    updated_at DateTime
)
ENGINE = MergeTree()
ORDER BY id;

CREATE TABLE demo_tables.order_items
(
    id UInt64,
    order_id UInt64,
    product_id UInt64,
    quantity UInt32,
    price Float64,
    cost_price Float64,
    created_at DateTime,
    updated_at DateTime
)
ENGINE = MergeTree()
ORDER BY id;
