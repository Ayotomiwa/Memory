# Type: Java Service

## Read before any implementation task

- atlas/standards/java-services.md
- atlas/standards/aws-testing.md
- atlas/standards/observability.md

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| Event schemas | `data-events` classes | hand-rolled JSON |
| Structured logging / metrics / correlation ID | Shared Java observability library | custom logging setup |

Library reference pages:
- atlas/repos/data-events.md — if producing or consuming events
- atlas/repo-map/shared-libraries.md — public contracts

## If producing or consuming events

Also read:
- atlas/standards/event-contracts.md
- atlas/repo-map/dependency-map.md

## Runbooks

- atlas/runbooks/sqs-backlog-debugging.md — if consuming SQS queues
- atlas/runbooks/cloudformation-rollback.md — if the service owns a CloudFormation stack

## Concepts

- atlas/concepts/idempotency.md — if consuming events or SQS messages

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`

## Related

[[java-services]] | [[aws-testing]] | [[observability]] | [[data-events]] | [[event-contracts]] | [[dependency-map]] | [[shared-libraries]] | [[sqs-backlog-debugging]] | [[cloudformation-rollback]] | [[idempotency]]
