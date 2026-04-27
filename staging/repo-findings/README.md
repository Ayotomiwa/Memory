# staging/repo-findings/

Things you discover while working inside a repo that would surprise the next engineer.

## When to add a file here

- You found an implicit contract between two repos
- You discovered a non-obvious behavior in production code
- You learned that a test or build step has a hidden requirement
- You understood a piece of code that is not explained in its README
- You verified how an event is actually used downstream

## Minimum content

```
---
repo: <repo-name>
date: YYYY-MM-DD
author: <name>
---

# <short title>

## Context
What were you doing when you found this?

## Finding
The durable fact you want future engineers to know.

## Evidence
File paths, line numbers, log snippets, or links that prove it.

## Suggested atlas update
Which atlas page(s) should this change? (e.g., `atlas/repos/<repo>.md` — add to "Known gotchas")
```

## Compile target

Most repo findings land in:

- `atlas/repos/<repo>.md` — under "Known gotchas" or "Key connections"
- `atlas/dependency-map.md` — if the finding reveals a new cross-repo edge
- `atlas/standards/*.md` — if the finding generalizes into a rule
