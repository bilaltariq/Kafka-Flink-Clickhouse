-- Drop existing tables
DROP TABLE IF EXISTS demo_tables.products;
DROP TABLE IF EXISTS demo_tables.orders;
DROP TABLE IF EXISTS demo_tables.order_items;

-- Create products table
CREATE TABLE demo_tables.products (
    id String,
    name String,
    description String,
    price String,
    cost_price String,
    created_at String,
    updated_at String,
    operation String,
    _timestamp DateTime DEFAULT now(),
    cdc_timestamp DateTime
)
ENGINE = MergeTree
ORDER BY (id, cdc_timestamp);

-- Create orders table
CREATE TABLE demo_tables.orders (
    id String,
    customer_name String,
    status String,
    total_amount String,
    created_at String,
    updated_at String,
    operation String,
    _timestamp DateTime DEFAULT now(),
    cdc_timestamp DateTime
)
ENGINE = MergeTree
ORDER BY (id, cdc_timestamp);

-- Create order_items table
CREATE TABLE demo_tables.order_items (
    id String,
    order_id String,
    product_id String,
    quantity String,
    price String,
    cost_price String,
    created_at String,
    updated_at String,
    operation String,
    _timestamp DateTime DEFAULT now(),
    cdc_timestamp DateTime
)
ENGINE = MergeTree
ORDER BY (id, cdc_timestamp);
