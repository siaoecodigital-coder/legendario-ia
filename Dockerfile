FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    fontconfig \
    wget \
    fonts-liberation \
    fonts-open-sans \
    && rm -rf /var/lib/apt/lists/*

# Google Fonts: Montserrat, Oswald (Impact-style), Lato (Calibri-style)
RUN mkdir -p /usr/share/fonts/truetype/custom \
    && wget -q "https://github.com/google/fonts/raw/main/ofl/montserrat/static/Montserrat-Bold.ttf" \
       -O /usr/share/fonts/truetype/custom/Montserrat-Bold.ttf \
    && wget -q "https://github.com/google/fonts/raw/main/ofl/montserrat/static/Montserrat-Regular.ttf" \
       -O /usr/share/fonts/truetype/custom/Montserrat-Regular.ttf \
    && wget -q "https://github.com/google/fonts/raw/main/ofl/oswald/static/Oswald-Bold.ttf" \
       -O /usr/share/fonts/truetype/custom/Oswald-Bold.ttf \
    && wget -q "https://github.com/google/fonts/raw/main/ofl/lato/Lato-Regular.ttf" \
       -O /usr/share/fonts/truetype/custom/Lato-Regular.ttf \
    && fc-cache -f

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD uvicorn app:app --host 0.0.0.0 --port $PORT
