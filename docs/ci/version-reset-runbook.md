# Version reset runbook — seed the 0.1.0-alpha line

> **One-time MAINTAINER (admin) runbook.** Not run by CI, not by the
> implementing agent. Deletes the bogus `v0.1.0` tag + Release that the old
> auto-cut-on-push flow minted (it corresponds to no intentional contract
> release) and re-establishes the clean maturity-ladder scheme starting at
> `0.1.0-alpha`.

## Why

`v0.1.0` was auto-cut by the now-removed `release.yml` on a push to `main`; it
is not a deliberately released contract. As the org's source of "breaking", the
proto version line must be clean before consumers pin against it. The target
ladder is:

- `0.1.0-alpha.N` — the contract iterating on `development` (lint+breaking+build in
  isolation).
- `0.1.0-beta.1` — the first release candidate, consumed by the **joint
  firmware + app beta** for cross-stack integration sign-off.
- `1.0.0` — the **first stable contract** (we are deliberately not cutting it
  yet; the ladder reaches stable only once a beta is proven against both
  consumers).

## Precondition — high blast radius

This is the contract repo; deleting a tag that a consumer superproject pins
breaks that consumer's submodule resolution. **Before deleting `v0.1.0`,
confirm no consumer pins its commit:**

```bash
# In each consumer (sst-cam-app, sst-cam-firmware):
cd proto && git describe --tags --exact-match HEAD 2>/dev/null || git rev-parse HEAD
# Confirm the pinned commit is NOT the v0.1.0 commit. If any consumer pins it,
# re-pin that consumer to a real tag first (or coordinate the cutover).
```

## Steps

The "Release Tags" ruleset blocks tag deletion by design, so the bypass is
**mandatory, not optional**.

1. **Disable the deletion block.** In the GitHub UI, either temporarily set the
   "Release Tags" ruleset to **Disabled**, or add yourself to its **bypass
   list**. (See `rulesets.md` for the ruleset definition.)

2. **Delete the bogus Release and its tag:**

   ```bash
   gh release delete v0.1.0 --yes --cleanup-tag
   ```

   `--cleanup-tag` removes the underlying git tag along with the Release.

3. **Verify nothing bogus remains:**

   ```bash
   git fetch --tags --prune --prune-tags origin
   git tag -l 'v*'
   # Expect: no v0.1.0, and no other unintended v* tags.
   ```

4. **Re-enable the "Release Tags" ruleset immediately** (re-enable it / remove
   yourself from the bypass list). Do not leave the deletion block off.

## Seed the alpha line

With no stable tags present, `resolve-version.sh alpha` bumps from an implicit
`v0.0.0`, so the first `feat:` merge to `development` mints `v0.1.0-alpha.1`
automatically via `alpha.yml`. Two ways to seed:

- **Let it happen:** merge the first releasable (`feat:`) PR into `development`;
  `alpha.yml` mints `v0.1.0-alpha.1`.
- **Deterministic seed (manual dispatch):** run `alpha.yml` with the
  `version=v0.1.0` input (forwarded as `IN_VERSION`), which seeds
  `v0.1.0-alpha.1` regardless of the commit scan. Use this if the first merge is
  docs/chore-only or to mint a clean baseline immediately.

## After reset

- First development alpha is `v0.1.0-alpha.1`.
- Cut `release/0.1.0` when the alpha contract is ready → `release-beta.yml` mints
  `v0.1.0-beta.1` (the joint firmware+app beta vendors this commit).
- Promote `release/0.1.0 → main` only after consumer sign-off → `promote.yml`
  mints stable. The first stable is intended to be `1.0.0`.
