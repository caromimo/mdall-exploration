from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def read_main():
    # query the database here
    return {"msg": "Hello World"}
