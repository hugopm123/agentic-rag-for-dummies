# Use a stable Python version
FROM python:3.13-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=7860

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -u 1000 user
ENV PATH="/home/user/.local/bin:$PATH"

WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
# .dockerignore will handle excluding unnecessary files
COPY --chown=user . .

# Ensure scripts are executable
RUN chmod +x scripts/start.sh

# Switch to the non-root user
USER user

# Expose Gradio port
EXPOSE 7860

# Start the application using the helper script
CMD ["bash", "./scripts/start.sh"]
