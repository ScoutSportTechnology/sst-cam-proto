# Branch & tag rulesets — sst-cam-proto

> **STATUS: APPLIED (as of 2026-06-18).** The rulesets below are live —
> {Release Tags, development, main, release-branches} with OrgAdmin bypass.
> The required PR check contexts on `development` and `release/*` were switched
> to `lint`/`compile`/`test`. `main` still requires legacy `lint`/`breaking`/`build`;
> its ruleset must switch to `lint`/`compile`/`test` before a stable PR can merge.
> The runbook commands are kept below for reference / re-application.
>
> **One-time MAINTAINER runbook.** These `gh api` calls apply the GitHub
> rulesets that enforce the branch model. They are **not** run by CI and **not**
> by the implementing agent — a repo admin runs them once, in order, after the
> branch-model bootstrap (U0) and after the workflows have run once so the exact
> check-run names are known.

## Intent

| Branch | Rule |
| ------ | ---- |
| `development` (default) | PR required; green `lint` + `compile` + `test`; no direct push / force-push / deletion. |
| `main` | PR required, 1 approval (admin/hotfix bypass); current legacy required checks need a ruleset migration before a stable PR. `release.yml` promotes an existing rc on push, without building. No direct push / force-push / deletion. |
| `release/*` | PR required into it; green `lint` + `compile` + `test`; no force-push / deletion. |
| tags `v*` (Release Tags) | **Immutable**: creation of compliant SemVer tags allowed; update / delete / force-push blocked. Must permit `vX.Y.Z`, `vX.Y.Z-alpha.N`, `vX.Y.Z-beta.N`, `vX.Y.Z-rc.N`. |

`lint`, `compile`, and `test` are the three `ci.yml` PR job names and the
required status-check **contexts** on `development` and `release/*`.
`ci.yml` also runs on PRs into `main`, which still requires the removed legacy
checks until an administrator migrates its ruleset. Do not require the push-only
`release.yml` promote job as a PR status.

## Commands

Replace `:owner`/`:repo` via `gh` (`gh repo set-default` first) or hardcode
`ScoutSportTechnology/sst-cam-proto`. Each ruleset is created with
`gh api --method POST repos/:owner/:repo/rulesets --input <json>`.

### development ruleset

```bash
cat > /tmp/ruleset-development.json <<'JSON'
{
  "name": "development",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/heads/development"], "exclude": [] } },
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
          { "context": "compile" },
          { "context": "test" }
        ]
      } }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-development.json
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
          { "context": "compile" },
          { "context": "test" }
        ]
      } }
  ]
}
JSON
gh api --method POST repos/:owner/:repo/rulesets --input /tmp/ruleset-release.json
```

### Release Tags ruleset (immutable v*)

Permit creation of compliant SemVer tags (stable + `-alpha.N`/`-beta.N`/
`-rc.N` prereleases); block update / delete / force-push so a published tag is
immutable. `release.yml` and its called `publish.yml` create tags via the
default `GITHUB_TOKEN`, so creation must stay allowed.

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

1. Bootstrap `development` + flip default branch (U0).
2. Let `ci.yml` run once on a PR into `development`; capture the exact
   `lint` / `compile` / `test` context names.
3. Apply the rulesets above (this doc) last.
