FROM ubuntu:jammy
LABEL author "bendn"
LABEL org.opencontainers.image.description "godot builds containerized for quick use, contains rcedit, blender and wine"

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git git-lfs unzip sudo adb \
    openjdk-11-jdk-headless \
    wget zip rsync wine64 blender \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ARG GODOT_VERSION
ARG RELEASE_NAME

COPY ./templates.tpz /root/templates.tpz
COPY ./godot /usr/local/bin/godot

# Install editor settings
ADD https://raw.githubusercontent.com/bend-n/godot-builds/main/.github/editor-settings-4.tres /root/.config/godot/editor_settings-4.tres
ADD https://raw.githubusercontent.com/bend-n/godot-builds/main/.github/editor-settings-3.tres /root/.config/godot/editor_settings-3.tres

# Install rcedit
ADD https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe /usr/share/rcedit.exe
