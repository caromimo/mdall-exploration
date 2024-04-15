import os
import pg8000.native
import ijson

password = os.getenv("DATABASE_PASSWORD")

# Connect to the postgres database

con = pg8000.native.Connection("mdall", password=password)

# Import json data and insert into postgres table

with open("./data/companies.json", "rb") as file:
    for record in ijson.items(file, "item"):
        print(record)
        address = ",".join(
            filter(
                None,
                [record["addr_line_1"], record["addr_line_2"], record["addr_line_3"]],
            )
        )
        con.run(
            """INSERT INTO companies (id, name, address, postal_code, city, country, region, status) 
            VALUES (:id, :name, :address, :postal_code, :city, :country, :region, :status)""",
            id=record["company_id"],
            name=record["company_name"],
            address=address,
            postal_code=record["postal_code"],
            city=record["city"],
            country=record["country_cd"],
            region=record["region_cd"],
            status=record["company_status"],
        )

con.close()
