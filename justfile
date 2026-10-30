set shell := ["bash", "-uc"]

default:
    @just --list

up:
    @just _run 'true'

shell:
    @just _run 'exec bash'

lint:
    @just _run 'buf format -d --exit-code && buf lint'

fmt:
    @just _run 'buf format -w'

compile:
    @just _run 'buf build'

test:
    @just _run 'scripts/ci/breaking-gate.sh'

test-device:
    @true

build:
    @just _run 'mkdir -p dist && buf build -o dist/sst-cam-proto.binpb'

ci:
    @just lint & lint_pid=$!; just compile && just test; result=$?; wait "$lint_pid" || exit $?; exit "$result"

clean:
    @just _run 'rm -rf dist'

breaking:
    @just _run 'buf breaking --against "${AGAINST:-.git#branch=${BASE:-origin/development}}"'

_run cmd:
    @if [ -f /.dockerenv ] && [ -d /workspaces/sst-cam-proto ]; then \
        bash -uc {{ quote(cmd) }}; \
    else \
        just _container {{ quote(cmd) }}; \
    fi

_container cmd:
    @_DC="$(command -v devcontainer || echo "$HOME/.devcontainers/bin/devcontainer")"; \
    _git_dir="$(git rev-parse --path-format=absolute --git-common-dir)"; \
    _mount=(); \
    if [ "$_git_dir" != "{{ justfile_directory() }}/.git" ]; then \
        _mount=(--mount "type=bind,source=$_git_dir,target=$_git_dir"); \
    fi; \
    _env=(); \
    for _name in BASE AGAINST PR_TITLE; do \
        if [ "${!_name+x}" ]; then _env+=(--remote-env "$_name=${!_name}"); fi; \
    done; \
    "$_DC" up --workspace-folder "{{ justfile_directory() }}" "${_mount[@]}" >/dev/null && \
    "$_DC" exec --workspace-folder "{{ justfile_directory() }}" "${_env[@]}" bash -uc {{ quote(cmd) }}
