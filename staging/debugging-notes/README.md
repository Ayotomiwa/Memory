# staging/debugging-notes/

Debugging sessions worth preserving.

Separate from `incidents/` — these are non-incident investigations that still produced useful knowledge.

## When to add a file here

- You spent non-trivial time tracking down a bug or mystery
- You found a reproduction for a flaky test or intermittent failure
- You pinned down an environment-specific behavior
- You learned something about a library, framework, or runtime that was not documented

## Minimum content

```
---
date: YYYY-MM-DD
repo: <repo-name>
symptom: <one line>
---

# <title>

## Symptom
What was broken or weird?

## Investigation
Key steps taken, in order.

## Finding
The actual cause.

## Fix
What was changed, with file paths or MR link.

## Durable learnings
1-3 things future engineers should know.
```

## Compile target

- `atlas/runbooks/*.md` — if the investigation can be turned into a playbook
- `atlas/repos/<repo>.md` — under "Known gotchas"
- `atlas/standards/*.md` — if it reveals a missing rule
- the relevant `atlas/standards/*.md` page — if it teaches a subtle technical pattern
