-- Products Table
DROP TABLE IF EXISTS demo_tables.products_ch;

CREATE TABLE demo_tables.products_ch
(
    id UInt64,
    name String,
    description String,
    price Float64,
    cost_price Float64,
    created_at DateTime64(3),
    updated_at DateTime64(3),
    cdc_time DateTime64(3)
)
ENGINE = MergeTree
ORDER BY (id);

-- Orders Table
DROP TABLE IF EXISTS demo_tables.orders_ch;

CREATE TABLE demo_tables.orders_ch
(
    id UInt64,
    customer_name String,
    status String,
    total_amount Float64,
    created_at DateTime64(3),
    updated_at DateTime64(3),
    cdc_time DateTime64(3)
)
ENGINE = MergeTree
ORDER BY (id);

-- Order Items Table
DROP TABLE IF EXISTS demo_tables.order_items_ch;

CREATE TABLE demo_tables.order_items_ch
(
    id UInt64,
    order_id UInt64,
    product_id UInt64,
    quantity Int32,
    price Float64,
    cost_price Float64,
    created_at DateTime64(3),
    updated_at DateTime64(3),
    cdc_time DateTime64(3)
)
ENGINE = MergeTree
ORDER BY (id);
