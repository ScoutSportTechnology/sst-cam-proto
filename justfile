# SST Cam proto — task runner.
#
# Recipes run natively when you're INSIDE the dev container, and transparently
# delegate to the container via the `devcontainer` CLI when run from the HOST.
#
# This repo ships only the .proto contract: buf lints it and checks for breaking
# changes. Consumers (app, firmware) vendor it as a git submodule and generate
# their own bindings — there is no codegen here.
#
# Requirements:
#   - Host:         `just` + the `devcontainer` CLI on PATH (or at ~/.devcontainers/bin).
#   - In-container: buf (baked into the image).
# Start the container once from the host with `just up` before delegating.

set shell := ["bash", "-uc"]

# List recipes.
default:
    @just --list

# --- container lifecycle (host-side) --------------------------------------

# Start the dev container (no-op if already running).
up:
    @_DC="$(command -v devcontainer || echo "$HOME/.devcontainers/bin/devcontainer")"; "$_DC" up --workspace-folder "{{justfile_directory()}}"

# Open an interactive shell in the dev container.
shell:
    @_DC="$(command -v devcontainer || echo "$HOME/.devcontainers/bin/devcontainer")"; "$_DC" exec --workspace-folder "{{justfile_directory()}}" bash

# --- buf recipes (auto native-or-delegated) -------------------------------

# Lint the protos (DEFAULT rules, see buf.yaml).
lint:
    @just _run "buf lint"

# Check for breaking changes against main.
breaking:
    @just _run "buf breaking --against '.git#branch=main'"

# --- internal -------------------------------------------------------------

# Run a command natively in-container, or delegate from the host.
_run cmd:
    @if [ -f /.dockerenv ] || [ -n "${REMOTE_CONTAINERS:-}${CODESPACES:-}" ]; then \
        bash -uc "{{cmd}}"; \
    else \
        _DC="$(command -v devcontainer || echo "$HOME/.devcontainers/bin/devcontainer")"; \
        "$_DC" exec --workspace-folder "{{justfile_directory()}}" bash -uc "{{cmd}}"; \
    fi
