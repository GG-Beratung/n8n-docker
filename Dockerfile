ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# ffmpeg
RUN apk add --no-cache \
    ffmpeg \
    ffmpeg-dev \
    at-spi2-core \
    gtk+3.0 \
    nss \
    alsa-lib \
    libxcomposite \
    libxdamage \
    libxrandr \
    libdrm \
    libgbm \
    libx11 \
    libxfixes \
    libxext \
    eudev \
    && rm -rf /var/cache/apk/*

USER node

# ffmpeg
RUN ffmpeg -version