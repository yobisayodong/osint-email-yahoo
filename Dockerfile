FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project
COPY . .

# Install tools dasar
RUN apt-get update && apt-get install -y git

# Clone theHarvester (karena tidak ada di PyPI)
RUN git clone https://github.com/laramies/theHarvester.git /app/theHarvester \
    && pip install -r /app/theHarvester/requirements.txt

# Install semua library di requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set entrypoint ke script utama kamu
CMD ["python3", "auto_osint_filter.py"]
