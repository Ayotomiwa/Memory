# Type: Java Service

## Read before any implementation task

- atlas/standards/java-services.md
- atlas/standards/aws-testing.md

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| Event schemas | `data-lib-events` classes | hand-rolled JSON |
| Structured logging / metrics / correlation ID | Shared Java logging/metrics library | custom logging setup |

Library reference pages:
- atlas/repos/data-lib-events.md — if producing or consuming events
- atlas/dependency-map.md — public contracts

## If producing or consuming events

Also read:
- atlas/standards/event-contracts.md
- atlas/dependency-map.md

## Runbooks

- atlas/runbooks/sqs-backlog-debugging.md — if consuming SQS queues
## Runtime rules

- If consuming events or SQS messages, handlers must be idempotent. See `atlas/standards/aws-lambda.md`.

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`
