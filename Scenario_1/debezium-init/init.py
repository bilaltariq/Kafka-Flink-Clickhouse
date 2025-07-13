import json
import requests
import os

CONNECTOR_NAME = "debezium-mysql-connector"
KAFKA_CONNECT_URL = "http://localhost:8083"

# Step 1: Delete existing connector if it exists
delete_url = f"{KAFKA_CONNECT_URL}/connectors/{CONNECTOR_NAME}"
try:
    res_del = requests.delete(delete_url)
    if res_del.status_code == 204:
        print(f"[✔] Connector '{CONNECTOR_NAME}' deleted successfully.")
    elif res_del.status_code == 404:
        print(f"[i] Connector '{CONNECTOR_NAME}' not found — nothing to delete.")
    else:
        print(f"[!] Failed to delete connector '{CONNECTOR_NAME}': {res_del.status_code} - {res_del.text}")
except Exception as e:
    print(f"[✘] Error deleting connector: {e}")

# Step 2: Load new connector config from file
json_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'igb-public-tools', 'kafka', 'debezium-mysql-connector.json'))
with open(json_path) as f:
    payload = json.load(f)

# Step 3: Create new connector
try:
    res = requests.post(
        f"{KAFKA_CONNECT_URL}/connectors",
        headers={'Content-Type': 'application/json'},
        json=payload
    )

    print(f"[→] Creating connector '{CONNECTOR_NAME}'...")
    print(f"[📡] Status Code: {res.status_code}")
    print(f"[📡] Response: {res.text}")
except Exception as e:
    print(f"[✘] Error creating connector: {e}")
