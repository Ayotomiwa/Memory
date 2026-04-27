---
date: YYYY-MM-DD
repo: <repo-name>
deprecated_by: <name>
---

# Deprecation: <repo-name>

## Reason for deprecation
Why is this repo being retired?

## Effective date
When does it stop receiving changes / go offline?

## Successor
- Repo: <successor repo name, or "none">
- Migration notes: <what consumers need to do, if anything>

## Consumers that need to migrate
List repos from [dependency-map](../../atlas/dependency-map.md) that depend on this repo and will be affected.

- [ ] <repo> — what they need to change
- [ ] <repo> — what they need to change

## Atlas pages to update
- [ ] [repo-catalog](../../atlas/repo-catalog.md) — mark as deprecated
- [ ] [dependency-map](../../atlas/dependency-map.md) — remove or update edges
- [ ] Repo ownership and AWS context removed or updated on the repo page
- [ ] Shared-library edges removed or updated in [dependency-map](../../atlas/dependency-map.md), if applicable
- [ ] Any flow pages that include this repo

## Known risks
Anything that could go wrong during the deprecation. Can be empty.
