from fastapi import FastAPI
from app.api import chat

app = FastAPI()

app.include_router(chat.router, prefix="/api/chat")

@app.get("/")
async def root():
    return {"message": "Hello from the Hardware Security AI Agent"}
