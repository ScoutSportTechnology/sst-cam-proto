# Branch & tag rulesets — sst-cam-proto

> **STATUS: APPLIED (as of 2026-06-18).** The rulesets below are live —
> {Release Tags, develop, main, release-branches} with OrgAdmin bypass.
> `develop` requires `lint`/`breaking`/`build`; `main`'s required checks are
> deferred. The runbook commands are kept below for reference / re-application.
>
> **One-time MAINTAINER runbook.** These `gh api` calls apply the GitHub
> rulesets that enforce the branch model. They are **not** run by CI and **not**
> by the implementing agent — a repo admin runs them once, in order, after the
> branch-model bootstrap (U0) and after the workflows have run once so the exact
> check-run names are known.

## Intent

| Branch | Rule |
| ------ | ---- |
| `develop` (default) | PR required; green `lint` + `breaking` + `build`; no direct push / force-push / deletion. |
| `main` | PR required; green `lint` + `breaking` + `build` (these run on the `release/*→main` PR via the `pull_request`-gated checks in `release-alpha.yml`/`release-beta.yml` — directly realizing the required checks, AE4); no direct push / force-push / deletion; admin/hotfix bypass. |
| `release/*` | PR required into it; green `lint` + `breaking` + `build`; no force-push / deletion. |
| tags `v*` (Release Tags) | **Immutable**: creation of compliant SemVer tags allowed; update / delete / force-push blocked. Must permit `vX.Y.Z`, `vX.Y.Z-alpha.N`, `vX.Y.Z-beta.N`. |

`lint`, `breaking`, and `build` are the three `pull_request` gate job names
(folded into `release-alpha.yml`/`release-beta.yml`). They are the
required status-check **contexts**. Capture them from a real run (a throwaway PR
into `develop`) before wiring — GitHub matches on the exact context string.

> **⚠ OPEN CAVEAT — DO NOT RESOLVE HERE, FLAG ONLY.**
> The `alpha` / `release-beta` / `promote` workflows run on **push** events, not
> on the PR. Required status checks on a branch ruleset gate the **PR** and are
> satisfied by check-runs reported against the PR head SHA. It must be verified
> that GitHub surfaces a `push`-event check-run as a **PR status on the same
> SHA** — if it does **not**, the `release/*→main` PR cannot be gated on a
> push-triggered job, and a lightweight **no-build assertion gate** (a tiny
> `pull_request`-triggered job that re-asserts the beta tag / contract invariant)
> must be added so `main`'s required check is realizable. For proto specifically
> this is mitigated because the gate (`lint`/`breaking`/`build`, folded into
> `release-alpha.yml`/`release-beta.yml`) **is** `pull_request`-triggered and
> runs on the `release/*→main` PR — so the three required checks are realizable
> via the PR directly. The caveat remains for any ruleset that would try to
> require a push-only job (e.g. the `push:[main]` promote in `release.yml`) as a
> PR status. Verify before relying on it; do not assume.

## Commands

Replace `:owner`/`:repo` via `gh` (`gh repo set-default` first) or hardcode
`ScoutSportTechnology/sst-cam-proto`. Each ruleset is created with
`gh api --method POST repos/:owner/:repo/rulesets --input <json>`.

### develop ruleset

```bash
cat > /tmp/ruleset-develop.json <<'JSON'
{
  "name": "develop",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/heads/develop"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": false,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false
      } },
    { "type": "required_status_checks",
      "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [
          { "context": "lint" },
          { "context": "breaking" },
          { "context": "build" }
        ]
      } }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-develop.json
```

### main ruleset (admin/hotfix bypass)

```bash
cat > /tmp/ruleset-main.json <<'JSON'
{
  "name": "main",
  "target": "branch",
  "enforcement": "active",
  "bypass_actors": [
    { "actor_id": 5, "actor_type": "RepositoryRole", "bypass_mode": "always" }
  ],
  "conditions": { "ref_name": { "include": ["refs/heads/main"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": false,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false
      } },
    { "type": "required_status_checks",
      "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [
          { "context": "lint" },
          { "context": "breaking" },
          { "context": "build" }
        ]
      } }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-main.json
```

> `actor_id: 5` is the built-in **admin** RepositoryRole — the hotfix bypass.
> Confirm the id in your org (`gh api repos/:owner/:repo/rulesets/<id>` after a
> dry run, or the org role list).

### release/* ruleset

```bash
cat > /tmp/ruleset-release.json <<'JSON'
{
  "name": "release-branches",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/heads/release/**"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": false,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false
      } },
    { "type": "required_status_checks",
      "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [
          { "context": "lint" },
          { "context": "breaking" },
          { "context": "build" }
        ]
      } }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-release.json
```

### Release Tags ruleset (immutable v*)

Permit creation of compliant SemVer tags (stable + `-alpha.N`/`-beta.N`
prereleases); block update / delete / force-push so a published tag is
immutable. The `alpha` / `release-beta` / `promote` workflows create tags via
the default `GITHUB_TOKEN`, so creation must stay allowed.

```bash
cat > /tmp/ruleset-tags.json <<'JSON'
{
  "name": "Release Tags",
  "target": "tag",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/tags/v*"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "update" }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-tags.json
```

> `deletion` + `update` + `non_fast_forward` block delete/move/force; tag
> **creation** is not restricted, so the workflows can mint `v*` tags. To delete
> a bogus tag (see `version-reset-runbook.md`) an admin must temporarily disable
> this ruleset or add themselves to a bypass list — deletion is mandatory-blocked
> by design.

## Ordering

1. Bootstrap `develop` + flip default branch (U0).
2. Let the `pull_request` gate (in `release-alpha.yml`) run once on a throwaway
   PR into `develop`; capture the exact `lint` / `breaking` / `build` context
   names.
3. Apply the rulesets above (this doc) last.
