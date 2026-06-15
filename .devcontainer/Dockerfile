# SST Cam proto — local tooling image.
#
# This repo ships only the .proto contract; the only tooling needed locally is
# buf (lint + breaking-change checks), matching CI. No codegen toolchain — both
# consumers generate their own bindings from the submodule.
FROM debian:stable-slim

# --- OS packages ----------------------------------------------------------
# git: buf breaking reads history; ca-certificates/curl: fetch the buf binary;
# just: backs the repo justfile.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# just task runner (single static binary, installed to /usr/local/bin).
RUN curl -fsSL https://just.systems/install.sh \
        | bash -s -- --to /usr/local/bin

# --- buf ------------------------------------------------------------------
# Download the latest buf release binary for linux x86_64.
RUN curl -fsSL \
        "https://github.com/bufbuild/buf/releases/latest/download/buf-Linux-x86_64" \
        -o /usr/local/bin/buf \
    && chmod +x /usr/local/bin/buf

WORKDIR /workspaces/sst-cam-proto
