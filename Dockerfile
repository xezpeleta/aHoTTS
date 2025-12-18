FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir huggingface_hub

COPY . /app

# Ensure ONNX runtime shared library is found
ENV LD_LIBRARY_PATH=/app

ENTRYPOINT ["python", "synthesize.py"]



