import json
import requests
import os

# Path to the JSON file from the current script location
json_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'kafka', 'debezium-mysql-connector.json'))

with open(json_path) as f:
    payload = json.load(f)

res = requests.post(
    'http://localhost:8083/connectors',
    headers={'Content-Type': 'application/json'},
    json=payload
)

print(f"Status Code: {res.status_code}")
print(f"Response: {res.text}")
