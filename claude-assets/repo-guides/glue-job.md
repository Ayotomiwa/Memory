# Type: Glue Job (PySpark)

## Read before any implementation task

- atlas/standards/python-services.md
- atlas/standards/aws-testing.md
- Glue jobs must be idempotent: overwrite target partitions fully, never append, and rerun the same input in `dev` to confirm output is unchanged.

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| S3 reads/writes | `data-lib-platform-pylib.GlueAdapter` or `S3Client` | raw boto3 or bare Spark S3 paths |
| Structured logging / correlation ID | `data-lib-platform-pylib.CorrelationContext` | `print` |
| Event schemas | `data-lib-events` classes | hand-rolled dicts or JSON |

Library reference pages:
- atlas/repos/data-lib-platform-pylib.md
- atlas/repos/data-lib-events.md — if producing or consuming events
- atlas/dependency-map.md — public contracts

## If producing or consuming events

Also read:
- atlas/standards/event-contracts.md
- atlas/dependency-map.md

## Runbooks

- atlas/runbooks/sqs-backlog-debugging.md — if triggered via EventBridge/SQS

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`
