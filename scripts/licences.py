import os
import pg8000.native
import ijson

password = os.getenv("DATABASE_PASSWORD")

# Connect to the postgres database

con = pg8000.native.Connection("mdall", password=password)

# Import json data and insert into postgres table

with open("./data/licences.json", "rb") as file:
    for record in ijson.items(file, "item"):
        print(record)
        con.run(
            """INSERT INTO companies (number, status, risk_class, created_on, refreshed_on, expired_on, licence_type_id, company_id) 
            VALUES (:number, :status, :risk_class, :created_on, :refreshed_on, :expired_on, :licence_type_id, :company_id)""",
            number=record["original_licence_no"],
            status=record["licence_status"],
            risk_class=["appl_risk_class"],
            created_on=record["first_licence_status_dt"],
            refreshed_on=record["last_refresh_dt"],
            expired_on=record["end_date"],
            licence_type_id=record[""],
            company_id=record[""],
        )


# "original_licence_no":82237,
# "licence_status":"I",
# "appl_risk_class":3,
# "licence_name":"ACTIFUSE SILICATED CALCIUM PHOSPHATE",
# "first_licence_status_dt":"2010-03-08",
# "last_refresh_dt":"2024-04-11",
# "end_date":null,
# "licence_type_cd":"F",
# "company_id":129031,
# "licence_type_desc":"Device Family"}


con.close()
