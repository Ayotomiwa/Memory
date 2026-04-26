# ADR-NNNN: <title>

> Replace `NNNN` with a monotonic 4-digit number. Title is a short imperative or descriptive phrase.

## Status

<draft | proposed | accepted | superseded | rejected>

If superseded, link to the superseding ADR.

## Context

What problem are we solving? What constraints do we have? What background does the reader need?

## Decision

What we are doing. One paragraph, assertive voice.

## Alternatives considered

- **Option A** — <short description>. Rejected because <reason>.
- **Option B** — <short description>. Rejected because <reason>.
- **Option C** — <short description>. Chosen (this ADR).

## Consequences

### Positive
- Bullet list.

### Negative / trade-offs
- Bullet list.

### Follow-ups
- Tasks that this decision creates.

## Affected repos

- [[<repo-name>]]
- [[<repo-name>]]

## Affected flows / standards / concepts

- [[<flow-name>]]
- [[<standard-name>]]

## References

- Source notes in `staging/decisions/` or `staging/meeting-notes/`
- Related MRs / tickets

---

## Example — ADR-0001: Use a shared `data-events` library

> Filled-in example showing how a real ADR looks.

**Status:** accepted

**Context:** Each producer defined its own event shape. Consumers copy-pasted types or parsed loosely, causing schema drift and a production incident where a producer added a required field and three consumers silently dropped the message.

**Decision:** Create and maintain [[data-events]] as the sole source of event type definitions. Every producer and consumer imports types from this library; hand-rolled event JSON is a review-blocker.

**Alternatives considered:**
- Per-service schemas — what we had. Rejected: caused observed incidents.
- Schema registry — heavier operational surface. Reasonable future option if producer count grows.
- Shared library — chosen. Lightweight, fits the team's tooling.

**Consequences:** Single source of truth; Python and Java stay aligned. Trade-off: cross-team coordination on library releases.

**Affected repos:** [[data-events]], [[ingestion-lambdas]], [[quality-checks-lambda]], [[curated-etl-glue]], [[lineage-service]]
