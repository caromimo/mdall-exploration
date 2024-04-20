import os
import pg8000.native
import ijson

password = os.getenv("DATABASE_PASSWORD")

# Connect to the postgres database

con = pg8000.native.Connection("mdall", password=password)

# Import json data and insert into postgres table
# TODO: FIXME
with open("./data/licences.json", "rb") as file:
    for record in ijson.items(file, "item"):
        print(record)
        con.run(
            """INSERT INTO licences (number, status, risk_class, created_on, refreshed_on, expired_on, licence_type_id, company_id) 
            VALUES (:number, :status, :risk_class, :created_on, :refreshed_on, :expired_on, :licence_type_id, :company_id)""",
            number=record["original_licence_no"],
            status=record["licence_status"],
            risk_class=record["appl_risk_class"],
            created_on=record["first_licence_status_dt"],
            refreshed_on=record["last_refresh_dt"],
            expired_on=record["end_date"],
            licence_type_id=record[
                "licence_type_cd"
            ],  # FIXME use the code to pull the id from the licence_type table
            company_id=record["company_id"],  # FIXME most likely similar to above
        )

con.close()
