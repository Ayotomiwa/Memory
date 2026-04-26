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
List repos from [[dependency-map]] that depend on this repo and will be affected.

- [ ] <repo> — what they need to change
- [ ] <repo> — what they need to change

## Atlas pages to update
- [ ] [[repo-catalog]] — mark as deprecated
- [ ] [[dependency-map]] — remove or update edges
- [ ] [[shared-libraries]] — if applicable
- [ ] [[aws-resources]] — if applicable
- [ ] [[ownership]] — if applicable
- [ ] Any flow pages that include this repo

## Known risks
Anything that could go wrong during the deprecation. Can be empty.
