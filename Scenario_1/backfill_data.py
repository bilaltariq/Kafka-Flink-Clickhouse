import mysql.connector
from clickhouse_connect import get_client
from datetime import datetime
from typing import List, Tuple

# === Configuration ===
MYSQL_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'rootpass',
    'database': 'demo',
    'port': 3310
}

CLICKHOUSE_CONFIG = {
    'host': 'localhost',
    'port': 8123,
    'database': 'demo_tables',
    'table': 'products'
}

BACKFILL_DATE = '2025-07-19'  # <-- Hardcoded date here

# === Functions ===

def fetch_mysql_data(backfill_date: str) -> List[Tuple]:
    conn = mysql.connector.connect(**MYSQL_CONFIG)
    cursor = conn.cursor()
    
    query = f"""
    SELECT 
        id, name, description, price, created_at 
    FROM 
        products 
    WHERE 
        DATE(created_at) = %s
    """
    cursor.execute(query, (backfill_date,))
    rows = cursor.fetchall()
    print(f"Fetched {len(rows)} rows from MySQL.")
    cursor.close()
    conn.close()
    return rows

def get_existing_ids_from_clickhouse(client, ids: List[int]) -> set:
    if not ids:
        return set()
    id_list = ",".join(map(str, ids))
    query = f"SELECT id FROM demo_tables.{CLICKHOUSE_CONFIG['table']} WHERE id IN ({id_list})"
    result = client.query(query)
    existing_ids = {row[0] for row in result.result_rows}
    print(f"{len(existing_ids)} IDs already exist in ClickHouse.")
    return existing_ids

def insert_into_clickhouse(client, rows):
    # Convert all values in each row to strings
    rows_as_str = [[str(value) for value in row] for row in rows]

    client.insert(
        table='demo_tables.products',
        data=rows_as_str,
        column_names=['id', 'name', 'description', 'price', 'created_at']
    )



def main(backfill_date: str):
    # Step 1: Fetch data from MySQL
    mysql_rows = fetch_mysql_data(backfill_date)

    
    if not mysql_rows:
        print("No data to process.")
        return

    ids = [row[0] for row in mysql_rows]

    # Step 2: Connect to ClickHouse
    ch_client = get_client(host=CLICKHOUSE_CONFIG['host'], port=CLICKHOUSE_CONFIG['port'])

    # Step 3: Fetch existing IDs
    existing_ids = get_existing_ids_from_clickhouse(ch_client, ids)

    # Step 4: Filter out already existing rows
    new_rows = [row for row in mysql_rows if row[0] not in existing_ids]

    #print(new_rows)
    #exit(0)
    # Step 5: Insert into ClickHouse
    insert_into_clickhouse(ch_client, new_rows)

if __name__ == "__main__":
    main(BACKFILL_DATE)
