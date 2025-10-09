ARG N8N_VERSION=latest

# Use Node.js Debian-based image as base, then install n8n
FROM node:18-bullseye-slim

USER root

# Install n8n and dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libglib2.0-0 libgobject-2.0-0 libgio-2.0-0 \
    libnss3 libnspr4 libsmime3 \
    libatk1.0-0 libatk-bridge2.0-0 libatspi2.0-0 \
    libcups2 libdbus-1-3 \
    libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 \
    libxkbcommon0 libxcb1 libxshmfence1 libxrender1 libxss1 \
    libgbm1 libgtk-3-0 \
    libcairo2 libpango-1.0-0 \
    libasound2 libdrm2 libudev1 \
    ca-certificates fonts-liberation fonts-noto-color-emoji \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Install n8n globally
RUN npm install -g n8n

# Create n8n user
RUN useradd -m -u 1000 node || true

USER node

# Set environment variables
ENV N8N_USER_FOLDER=/home/node/.n8n

# Expose n8n port
EXPOSE 5678

# Verify ffmpeg installation
RUN ffmpeg -version

CMD ["n8n"]