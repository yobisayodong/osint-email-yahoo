FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project
COPY . .

# Install tools dasar
RUN apt-get update && apt-get install -y git dnsutils whois build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install library langsung dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install theHarvester langsung dari PyPI (tidak pakai git clone)
RUN pip install theHarvester

# Set entrypoint ke script utama
CMD ["python3", "auto_osint_filter.py"]
