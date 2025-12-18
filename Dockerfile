FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir huggingface_hub

# Create non-root user with UID 1000
RUN useradd -u 1000 -m appuser

COPY . /app

# Ensure app files are owned by non-root user
RUN chown -R appuser:appuser /app

# Ensure ONNX runtime shared library is found
ENV LD_LIBRARY_PATH=/app

USER 1000

ENTRYPOINT ["python", "synthesize.py"]



