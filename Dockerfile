ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# ffmpeg
RUN apk add --no-cache \
    ffmpeg \
    ffmpeg-dev \
    && rm -rf /var/cache/apk/* \
    && apt-get update \
    && apt-get install -y libatspi2.0-0 libatk-bridge2.0-0 libgtk-3-0

USER node

# ffmpeg
RUN ffmpeg -version