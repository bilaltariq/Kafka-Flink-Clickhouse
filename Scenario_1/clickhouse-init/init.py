import os
import clickhouse_connect

# Path to directory containing the SQL files
sql_dir = os.path.dirname(__file__)  # change this to your actual path

# Ordered list of SQL filenames you want to run
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
    password=''  # set if needed
)

# Run each file one by one
for sql_file in sql_files:
    file_path = os.path.join(sql_dir, sql_file)
    print(f"📄 Executing {sql_file}...")

    with open(file_path, 'r') as f:
        content = f.read()

    for stmt in content.split(';'):
        stmt = stmt.strip()
        if stmt:
            try:
                client.command(stmt)
                print(f"Executed: {stmt[:80]}...")
            except Exception as e:
                print(f"Failed: {stmt[:80]}...\n   ↳ {e}")
