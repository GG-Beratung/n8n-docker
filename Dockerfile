ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# ffmpeg
RUN apk add --no-cache \
    ffmpeg \
    ffmpeg-dev \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    chromium-chromedriver \
    && rm -rf /var/cache/apk/*

USER node

# ffmpeg
RUN ffmpeg -version