FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy semua file project
COPY . .

# Install tools dasar
RUN apt-get update && apt-get install -y \

# Clone theHarvester & install
RUN git clone https://github.com/laramies/theHarvester \
    && pip install -r /app/theHarvester/requirements.txt

# Install semua library dari requirements.txt project kamu
RUN pip install --no-cache-dir -r requirements.txt

# Set entrypoint ke script utama kamu
CMD ["python3", "auto_osint_filter.py"]
