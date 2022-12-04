FROM ubuntu:jammy
LABEL author="bendn"

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git git-lfs unzip sudo adb \
    openjdk-11-jdk-headless \
    wget zip rsync wine64 \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ARG GODOT_VERSION
ARG RELEASE_NAME

COPY ./templates.tpz /root/templates.tpz 
COPY ./godot /usr/local/bin/godot
RUN mkdir ~/.cache \
    && mkdir -p /root/.config/godot \
    && mkdir -p /root/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && unzip -q /root/templates.tpz -d /root/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && rm /root/templates.tpz

# Install editor-settings.tres
ADD https://raw.githubusercontent.com/bend-n/godot-builds/main/.github/editor-settings.tres /root/.config/godot/editor_settings-3.tres

# Install rcedit
ADD https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe /usr/share/rcedit.exe
