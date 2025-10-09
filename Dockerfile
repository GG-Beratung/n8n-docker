ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# Install glibc compatibility for Playwright Chromium
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-bin-2.35-r1.apk \
    && apk add --no-cache --force-overwrite glibc-2.35-r1.apk glibc-bin-2.35-r1.apk \
    && rm glibc-2.35-r1.apk glibc-bin-2.35-r1.apk

# ffmpeg and chromium dependencies
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
    gcompat \
    libstdc++ \
    glib \
    && rm -rf /var/cache/apk/*

# Set library path for glibc
ENV LD_LIBRARY_PATH=/usr/glibc-compat/lib

USER node

# ffmpeg
RUN ffmpeg -version