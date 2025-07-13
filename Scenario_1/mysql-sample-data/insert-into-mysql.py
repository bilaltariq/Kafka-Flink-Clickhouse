import mysql.connector

# Define connection parameters
conn = mysql.connector.connect(
    host='localhost',
    port=3310,  # host port
    user='root',
    password='rootpass',
    database='demo'
)

cursor = conn.cursor()

# Path to your SQL file
sql_file = 'sample-data-insertion-mysql.sql'

with open(sql_file, 'r') as f:
    sql_statements = f.read()

# Split statements by semicolon (;) while ignoring empty lines
for statement in sql_statements.strip().split(';'):
    stmt = statement.strip()
    if stmt:
        try:
            cursor.execute(stmt)
            print(f"Executed: {stmt[:80]}...")
        except Exception as e:
            print(f"Error: {e}\n   ↳ Statement: {stmt[:80]}")

conn.commit()
cursor.close()
conn.close()
