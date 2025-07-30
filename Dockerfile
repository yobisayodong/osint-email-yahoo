FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project
COPY . .

# Install tools dasar
apt-get update && apt-get install -y git

# Clone theHarvester & install sebagai library
RUN git clone https://github.com/laramies/theHarvester.git /app/theHarvester \
    && pip install /app/theHarvester

# Install semua library dari requirements.txt kamu
RUN pip install --no-cache-dir -r requirements.txt

# Set entrypoint ke script utama
CMD ["python3", "auto_osint_filter.py"]
