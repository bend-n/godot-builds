FROM ubuntu:focal
LABEL author="bendn"

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    git-lfs \
    python \
    python-openssl \
    unzip \
    wget \
    zip \
    adb \
    openjdk-11-jdk-headless \
    rsync \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ARG GODOT_VERSION="3.5"
ARG RELEASE_NAME="rc"

COPY ./templates.tpz /root/templates.tpz 
COPY ./godot /usr/local/bin/godot
RUN mkdir ~/.cache \
    && mkdir -p /root/.config/godot \
    && mkdir -p /root/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && unzip -q /root/templates.tpz -d /root/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && rm /root/templates.tpz

# Install editor-settings.tres
ADD https://raw.githubusercontent.com/bend-n/godot-builds/main/.github/editor-settings.tres /root/.config/godot/editor_settings-3.tres

# Test if godot is working
RUN godot -e -q
