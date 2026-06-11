# SST Cam proto — local tooling image.
#
# Gives a reproducible environment with everything needed to lint, check
# breaking changes, and generate the Dart bindings locally — the same toolchain
# CI uses. buf drives codegen through the local `protoc-gen-dart` plugin (buf
# has its own codegen engine, so a standalone protoc is not required).
FROM dart:stable

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

# --- Dart protoc plugin ---------------------------------------------------
# protoc-gen-dart is provided by the protoc_plugin package; buf invokes it as a
# local plugin. Put the pub-cache bin dir on PATH so `protoc-gen-dart` resolves.
ENV PATH="/root/.pub-cache/bin:${PATH}"
RUN dart pub global activate protoc_plugin

WORKDIR /workspaces/sst-cam-proto
