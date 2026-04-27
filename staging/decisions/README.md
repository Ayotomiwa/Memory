# staging/decisions/

Rough decision notes, before they become formal ADRs.

Use this when a decision is forming but not yet ready to live in `atlas/decisions/`.

## Minimum content

```
---
date: YYYY-MM-DD
status: <draft | proposed | decided | rejected>
area: <e.g., events, infra, runtime>
---

# <decision title>

## Problem
What are we trying to solve?

## Options considered
- Option A: ...
- Option B: ...
- Option C: ...

## Leaning
Current direction and why.

## Open questions
- Q1

## Stakeholders
Who needs to sign off?
```

## Compile target

When the decision is finalized:

- Promote to `atlas/decisions/adr-NNNN-<slug>.md` using the `adr-template`.
- Link the ADR back to this raw note in staging.
- Update any affected `atlas/repos/*.md` or `atlas/flows/*.md` pages.
