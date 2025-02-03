#!/bin/bash

# Create project directories
mkdir -p hardware-security-ai-agent-python/app/api
mkdir -p hardware-security-ai-agent-python/.github/workflows

# Create app/main.py
cat <<'EOF' > hardware-security-ai-agent-python/app/main.py
from fastapi import FastAPI
from app.api import chat

app = FastAPI()

app.include_router(chat.router, prefix="/api/chat")

@app.get("/")
async def root():
    return {"message": "Hello from the Hardware Security AI Agent"}
EOF

# Create app/api/chat.py
cat <<'EOF' > hardware-security-ai-agent-python/app/api/chat.py
from fastapi import APIRouter
import os
import requests  # Example: for calling Azure OpenAI endpoints

router = APIRouter()

AZURE_API_KEY = os.environ.get("AZURE_API_KEY")
AZURE_RESOURCE_NAME = os.environ.get("AZURE_RESOURCE_NAME")
AZURE_DEPLOYMENT = os.environ.get("AZURE_DEPLOYMENT")

@router.post("/")
async def chat_handler(payload: dict):
    query = payload.get("query", "No query provided")
    # Here, implement your Azure OpenAI integration logic
    response = {
        "answer": f"Simulated response for: {query} regarding hardware security."
    }
    return response
EOF

# Create an empty __init__.py for package recognition
touch hardware-security-ai-agent-python/app/__init__.py

# Create requirements.txt
cat <<'EOF' > hardware-security-ai-agent-python/requirements.txt
fastapi
uvicorn
requests
EOF

# Create .gitignore
cat <<'EOF' > hardware-security-ai-agent-python/.gitignore
__pycache__/
*.pyc
.env
EOF

# Create README.md
cat <<'EOF' > hardware-security-ai-agent-python/README.md
# Hardware Security AI Agent (Python)

This project is a Python-based AI agent for handling hardware security queries.
It uses FastAPI as the backend framework and is designed to integrate with Azure OpenAI.
EOF

# Create a basic GitHub Actions workflow in .github/workflows/ci.yml
cat <<'EOF' > hardware-security-ai-agent-python/.github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
      - name: Run Tests
        run: echo "No tests configured yet."
EOF

echo "Project scaffold for Hardware Security AI Agent (Python) created successfully!"
