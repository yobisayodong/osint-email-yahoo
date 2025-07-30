# Base image
FROM python:3.11-slim

# Install system dependencies + theHarvester
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    nmap \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# Clone theHarvester
RUN git clone https://github.com/laramies/theHarvester.git /opt/theHarvester
WORKDIR /opt/theHarvester

# Install theHarvester dependencies
RUN pip install -r requirements.txt

# Back to app directory
WORKDIR /app

# Copy semua file dari repo
COPY . .

# Install requirements.txt project kamu
RUN pip install --no-cache-dir -r requirements.txt

# Jalankan script auto filter
CMD ["python3", "auto_osint_filter.py"]

