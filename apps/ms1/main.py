from fastapi import FastAPI
import httpx

app = FastAPI()

service_b_url = "http://ms2:8001"

# healthz and readyz specifically for K8s

@app.get("/healthz")
async def health():
    return {"status": "HEALTHY"}

@app.get("/readyz")
async def ready():
    return {"status": "READY"}

@app.get("/hello")
async def hello():
    return {"message": "Hello from Service 1"}

# simulate traffic between services

@app.get("/call-ms2")
async def call_b():
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{service_b_url}/hello")
        return {"service_1": "called service_2", "response": resp.json()}
