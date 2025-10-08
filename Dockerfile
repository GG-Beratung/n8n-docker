ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# 安裝 ffmpeg 和相關依賴
RUN apk add --no-cache \
    ffmpeg \
    ffmpeg-dev \
    && rm -rf /var/cache/apk/*

# 切換回原本的使用者
USER node

# 驗證 ffmpeg 安裝
RUN ffmpeg -version