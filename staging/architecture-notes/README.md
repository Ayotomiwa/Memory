# staging/architecture-notes/

Rough architecture thoughts, diagrams, design drafts.

## When to add a file here

- You are drafting a proposed design
- You want to capture a diagram before it becomes a flow page
- You are documenting a system boundary or integration pattern
- You are working through trade-offs and want a durable record

## Minimum content

```
---
date: YYYY-MM-DD
status: <draft | proposed | superseded>
area: <domain or flow name>
---

# <title>

## Context
What system / repos / flows are we reasoning about?

## Current state
Optional: how it works today.

## Proposed state
The change being described.

## Diagram
Mermaid, ASCII, or a link to an image file in this folder.

## Open questions
- Q1
```

## Compile target

- `atlas/flows/*.md` — when the draft solidifies into a real flow
- `atlas/decisions/*.md` — if the draft leads to an ADR
- `atlas/repos/*.md` — if it clarifies a single repo's role
