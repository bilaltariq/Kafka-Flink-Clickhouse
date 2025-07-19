import os
import clickhouse_connect
import re

# Path to directory containing the SQL files
sql_dir = os.path.dirname(__file__)  # Adjust if needed

sql_files = [
    'clickhouse-init-db.sql',
    'clickhouse-init-kafka-tables.sql',
    'clickhouse-init-mergetree-tables.sql',
    'clickhouse-init-materialized-views.sql'
]

# Connect to ClickHouse
client = clickhouse_connect.get_client(
    host='localhost',
    port=8123,
    username='default',
    password=''  # Add if needed
)

# Regex to match CREATE/DROP TABLE or VIEW statements
pattern = re.compile(
    r'(?i)(CREATE|DROP)\s+(TABLE|MATERIALIZED\s+VIEW)\s+(IF\s+(NOT\s+)?EXISTS\s+)?([^\s(]+)'
)

# Execute each SQL file
for sql_file in sql_files:
    file_path = os.path.join(sql_dir, sql_file)
    print(f"\n📄 Executing {sql_file}...")

    with open(file_path, 'r') as f:
        sql = f.read()

    for stmt in sql.split(';'):
        stmt = stmt.strip()
        if not stmt:
            continue

        match = pattern.match(stmt)
        table = match.group(5) if match else None

        try:
            client.command(stmt)
            if table:
                print(f"✅ Created/Dropped: {table}")
        except Exception as e:
            if table:
                print(f"❌ Failed on: {table}")
            print(f"   ↳ Reason: {e}")

# ✅ Update expected tables
expected_tables = [
    'demo_tables.products',
    'demo_tables.orders',
    'demo_tables.order_items',
    'kafka_tables.products_kafka',
    'kafka_tables.orders_kafka',
    'kafka_tables.order_items_kafka',
    'default.kafka_to_products',
    'default.kafka_to_orders',
    'default.kafka_to_order_items'
]

print("\n📦 Verifying table existence...")
for tbl in expected_tables:
    try:
        client.query(f"DESCRIBE TABLE {tbl}")
        print(f"✅ Found: {tbl}")
    except Exception as e:
        print(f"❌ Missing: {tbl}")
        print(f"   ↳ Reason: {e}")