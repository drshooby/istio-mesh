from fastapi import FastAPI
import httpx

app = FastAPI()

service_a_url = "http://ms1:8000"

# healthz and readyz specifically for K8s

@app.get("/healthz")
async def health():
    return {"status": "HEALTHY"}

@app.get("/readyz")
async def ready():
    return {"status": "READY"}

@app.get("/hello")
async def hello():
    return {"message": "Hello from Service 2"}

# simulate traffic between services

@app.get("/call-ms1")
async def call_b():
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{service_a_url}/hello")
        return {"service_2": "called service_1", "response": resp.json()}
