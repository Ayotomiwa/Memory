# staging/mr-summaries/

Notes from significant merge requests.

Most MRs do **not** need a file here. Only add one when the MR contains durable knowledge that would otherwise be lost.

## When to add a file here

- The MR changed a contract (event, API, shared library)
- The MR introduced a new pattern that should become a standard
- The MR review surfaced a non-obvious risk or gotcha
- The MR involved cross-repo coordination
- The MR was a rollback, and the rollback itself is instructive

If this is the **first meaningful MR merged to master for a new repo**, also create a `staging/new-repos/<date>-<repo>.md` entry alongside this file.

## Minimum content

```
---
date: YYYY-MM-DD
mr_url: <gitlab MR URL>
repo: <repo-name>
author: <name>
---

# MR !<number>: <title>

## What changed
Short summary.

## Why it matters
Durable impact on the system.

## Review highlights
Key comments or concerns from review.

## Testing strategy
How was this verified? Anything reusable?

## Suggested atlas updates
Which pages this MR should update.
```

## Compile target

- `atlas/repos/<repo>.md` — for repo-specific knowledge
- `atlas/standards/*.md` — for reusable patterns
- `atlas/decisions/*.md` — if the MR implements a decision
- `atlas/dependency-map.md` — for new cross-repo edges
