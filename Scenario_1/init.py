# main.py
import subprocess

subprocess.run(["python", "debezium-init/init.py"])
subprocess.run(["python", "clickhouse-init/init.py"])
