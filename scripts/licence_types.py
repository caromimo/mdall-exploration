import os
import pg8000.native
import ijson

password = os.getenv("DATABASE_PASSWORD")

# Connect to the postgres database

con = pg8000.native.Connection("mdall", password=password)

# Import json data and insert into postgres table

with open("./data/licence_types.json", "rb") as file:
    for record in ijson.items(file, "item"):
        print(record)
        con.run(
            "INSERT INTO licence_types (code, description) VALUES (:code, :description)",
            code=record["licence_type_cd"],
            description=record["licence_type_desc"],
        )

con.close()
