FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project
COPY . .

# Install tools dasar yang dibutuhkan
RUN apt-get update && apt-get install -y git nmap dnsutils whois build-essential \
    && rm -rf /var/lib/apt/lists/*

# Clone theHarvester & install requirements
RUN git clone https://github.com/laramies/theHarvester.git /app/theHarvester \
    && pip install -r /app/theHarvester/requirements.txt

# Install semua library dari requirements.txt project kamu
RUN pip install --no-cache-dir -r requirements.txt

# Set entrypoint ke script utama kamu
CMD ["python3", "auto_osint_filter.py"]
