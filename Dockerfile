FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project ke dalam container
COPY . .

# Install tools dasar
RUN apt-get update && apt-get install -y git

# Clone theHarvester lalu install langsung (tidak pakai requirements.txt)
RUN git clone https://github.com/laramies/theHarvester.git /app/theHarvester \
    && pip install /app/theHarvester

# Install semua library yang ada di requirements.txt kamu
RUN pip install --no-cache-dir -r requirements.txt

# Set entrypoint ke script utama kamu
CMD ["python3", "auto_osint_filter.py"]
