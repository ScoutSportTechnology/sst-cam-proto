#!/usr/bin/env bash
# =============================================================================
# breaking-gate.sh — the `breaking` PR check (release-alpha / release-beta).
#
# Runs `buf breaking` against the PR base branch (AGAINST), so it judges only
# what the PR itself changes. A wire break is allowed only when the PR title declares it the Conventional-Commit way
# (`type!:` or `type(scope)!:`). The title becomes the squash subject, or the
# body of a merge commit, so the declared break reaches resolve-version and the
# release bumps accordingly (minor while the major is 0, major after 1.0.0).
#
#   buf finds no break           -> pass (notice if the title declares one)
#   buf finds a break, declared  -> pass with a warning
#   buf finds a break, undeclared-> fail
#   buf itself errors            -> fail
#
# env:
#   PR_TITLE  pull request title (required)
#   AGAINST   buf input to compare against (CI passes the PR base branch;
#             default for local runs: this repo's development)
# =============================================================================
set -euo pipefail

against="${AGAINST:-https://github.com/ScoutSportTechnology/sst-cam-proto.git#branch=development}"
title="${PR_TITLE:?PR_TITLE is required}"

declared=false
if grep -qE '^[a-z]+(\([^)]*\))?!:' <<<"$title"; then
  declared=true
fi

format=text
[ -n "${GITHUB_ACTIONS:-}" ] && format=github-actions

set +e
buf breaking --against "$against" --error-format "$format"
rc=$?
set -e

case "$rc" in
  0)
    if [ "$declared" = true ]; then
      echo "::notice::The PR title declares a breaking change, but buf breaking found no wire break against the base branch."
    fi
    echo "breaking: no wire break against ${against}"
    ;;
  100)
    if [ "$declared" = true ]; then
      echo "::warning::buf breaking found wire breaks against the base branch. The PR title declares a breaking change, so this check passes. Consumers must re-pin and adapt."
      exit 0
    fi
    echo "::error::buf breaking found wire breaks against the base branch, but the PR title does not declare a breaking change. Remove the break, or retitle the PR as type(scope)!: ... and add a BREAKING CHANGE: footer."
    exit 1
    ;;
  *)
    echo "::error::buf breaking did not run (exit ${rc})."
    exit "$rc"
    ;;
esac
