#!/bin/bash
set -e

# Check if .env exists, if not create it from .env.example
if [ ! -f "project/.env" ]; then
    echo "📄 Creating .env from .env.example..."
    cp project/.env.example project/.env
fi

# Run the application
echo "🚀 Launching Agentic RAG Assistant (Gemini version)..."
# Ensure PYTHONPATH includes the project directory for modules to be found
export PYTHONPATH=$PYTHONPATH:$(pwd)/project
python project/app.py
