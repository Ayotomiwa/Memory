# staging/incidents/

Incident notes, postmortems, and production issue writeups.

## When to add a file here

- After any incident, regardless of severity
- After a near-miss that was caught before impact
- After a debugging session that resolved a recurring symptom

## Minimum content

```
---
date: YYYY-MM-DD
severity: <SEV1/2/3/4 or near-miss>
repos: [list of repos involved]
aws_resources: [list of AWS resources involved]
---

# <short title>

## What happened
Timeline of events, UTC.

## Impact
Who/what was affected.

## Root cause
Actual root cause, not the first symptom.

## Detection
How we noticed.

## Recovery
What fixed it.

## Durable learnings
The 1-3 things future engineers should know.

## Follow-ups
Links to MRs, tickets, or backlog items.
```

## Compile target

- `atlas/runbooks/*.md` — if the incident produced a reusable debugging playbook
- `atlas/repos/<repo>.md` — under "Known gotchas"
- `atlas/standards/*.md` — if the incident reveals a missing or wrong standard
- `atlas/decisions/*.md` — if the follow-up involves a design change
