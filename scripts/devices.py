import os
import pg8000.native
import ijson

password = os.getenv("DATABASE_PASSWORD")

# Connect to the postgres database

con = pg8000.native.Connection("mdall", password=password)

# Import json data and insert into postgres table

with open("./data/devices.json", "rb") as file:
    for record in ijson.items(file, "item"):
        print(record)
        con.run(
            "INSERT INTO devices (device_id, name, licence_number) VALUES (:device_id, :name, :licence_number)",
            device_id=record["device_id"],
            name=record["trade_name"],
            licence_number=record["original_licence_no"],
        )

con.close()
