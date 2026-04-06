import sys
import os
import logging

# Ensure the project directory is in the path
sys.path.insert(0, os.path.dirname(__file__))

from dotenv import load_dotenv
load_dotenv(os.path.join(os.path.dirname(__file__), ".env"))

# Suppress OTel "Failed to detach context" warning
class _SuppressOtelDetachWarning(logging.Filter):
    def filter(self, record):
        return "Failed to detach context" not in record.getMessage()

logging.getLogger("opentelemetry.context").addFilter(_SuppressOtelDetachWarning())

from ui.css import custom_css
from ui.gradio_app import create_gradio_ui

# Create the UI instance at module level for Gradio hot-reloading (gradio project/app.py)
print("\n🔨 Creating RAG Assistant...")
demo = create_gradio_ui()

if __name__ == "__main__":
    print("\n🚀 Launching RAG Assistant...")
    demo.launch(css=custom_css)