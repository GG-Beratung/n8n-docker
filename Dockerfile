ARG N8N_VERSION=latest

# Use Debian-based Node.js image
FROM node:20-bookworm-slim

USER root

# Install n8n dependencies and ffmpeg
RUN apt-get update && apt-get install -y \
    ffmpeg \
    graphicsmagick \
    libglib2.0-0 \
    libnss3 libnspr4 \
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
RUN npm install -g --omit=dev n8n

# Create n8n user and directories
RUN useradd -m -u 1000 -s /bin/bash n8nuser \
    && mkdir -p /home/n8nuser/.n8n \
    && chown -R n8nuser:n8nuser /home/n8nuser

USER n8nuser

# Set environment variables
ENV N8N_USER_FOLDER=/home/n8nuser/.n8n
WORKDIR /home/n8nuser

# Expose n8n port
EXPOSE 5678

# Verify ffmpeg installation
RUN ffmpeg -version

CMD ["n8n", "start"]