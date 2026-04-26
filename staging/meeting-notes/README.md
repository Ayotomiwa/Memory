# staging/meeting-notes/

Notes from design, architecture, and planning meetings.

## When to add a file here

The meeting produced at least one of:

- a decision worth remembering months later
- an agreed standard or convention
- an action item affecting multiple repos
- a change to a flow or architecture

If the meeting produced none of those, skip it.

## Minimum content

```
---
date: YYYY-MM-DD
attendees: [list]
topic: <short>
---

# <title>

## Decisions
- Decision 1
- Decision 2

## Open questions
- Q1
- Q2

## Action items
- [ ] <owner>: <action> (by <date>)

## Raw notes
Anything else worth preserving.
```

## Compile target

- `atlas/decisions/*.md` — formal ADRs for durable decisions
- `atlas/standards/*.md` — for newly agreed conventions
- `atlas/flows/*.md` — for flow or architecture changes
- `atlas/repos/*.md` — if repo-specific behavior was decided
