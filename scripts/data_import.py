import os
import pg8000.native

password = os.getenv("DB_PASSWORD")

# Connect to the postgres database with user name

con = pg8000.native.Connection("mdall", password=password)

# Create a temporary table

con.run("CREATE TEMPORARY TABLE book (id SERIAL, title TEXT)")

# Populate the table

for title in ("Ender's Game", "The Magus"):
    con.run("INSERT INTO book (title) VALUES (:title)", title=title)

# Print all the rows in the table

for row in con.run("SELECT * FROM book"):
    print(row)

con.close()

# from: https://pypi.org/project/pg8000/
