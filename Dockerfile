FROM python:3.13-slim

RUN apt-get update && apt-get install -y \
  gcc \
  default-libmysqlclient-dev \
  libssl-dev \
  pkg-config \
  curl \
  netcat-openbsd \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1