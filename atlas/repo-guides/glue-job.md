# Type: Glue Job (PySpark)

## Read before any implementation task

- atlas/standards/python-services.md
- atlas/standards/aws-testing.md
- atlas/standards/observability.md
- atlas/concepts/idempotency.md — Glue jobs must overwrite target partitions fully, never append

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| S3 reads/writes | `data-platform-pylib.GlueAdapter` or `S3Client` | raw boto3 or bare Spark S3 paths |
| Structured logging / correlation ID | `data-platform-pylib.CorrelationContext` | `print` |
| Event schemas | `data-events` classes | hand-rolled dicts or JSON |

Library reference pages:
- atlas/repos/data-platform-pylib.md
- atlas/repos/data-events.md — if producing or consuming events
- atlas/repo-map/shared-libraries.md — public contracts

## If producing or consuming events

Also read:
- atlas/standards/event-contracts.md
- atlas/repo-map/dependency-map.md

## Runbooks

- atlas/runbooks/sqs-backlog-debugging.md — if triggered via EventBridge/SQS

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`

## Related

[[python-services]] | [[aws-testing]] | [[observability]] | [[data-platform-pylib]] | [[data-events]] | [[event-contracts]] | [[dependency-map]] | [[shared-libraries]] | [[sqs-backlog-debugging]] | [[idempotency]]
