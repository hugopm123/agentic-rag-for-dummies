#!/bin/bash
set -e

# Check if .env exists, if not create it from .env.example
if [ ! -f "project/.env" ]; then
    echo "📄 Creating .env from .env.example..."
    cp project/.env.example project/.env
fi

# Run the application with Gradio CLI for hot-reloading
echo "🚀 Launching Agentic RAG Assistant with Hot-Reloading..."
# Ensure PYTHONPATH includes the project directory for modules to be found
export PYTHONPATH=$PYTHONPATH:$(pwd)/project
# Gradio CLI uses environment variables for host/port configuration
export GRADIO_SERVER_NAME=0.0.0.0
export GRADIO_SERVER_PORT=7860
# 'gradio project/app.py' automatically handles the watcher
gradio project/app.py
