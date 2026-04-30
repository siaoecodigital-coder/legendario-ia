FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    fontconfig \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Bundle fonts from repo (no network dependency at build time)
COPY fonts/ /usr/share/fonts/truetype/custom/
RUN fc-cache -f

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD uvicorn app:app --host 0.0.0.0 --port $PORT
