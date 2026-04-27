# Type: Python Lambda

## Read before any implementation task

- atlas/standards/python-services.md
- atlas/standards/aws-lambda.md
- atlas/standards/aws-testing.md

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| S3 reads/writes | `data-lib-platform-pylib.S3Client` | boto3 S3 directly |
| Structured logging / correlation ID | `data-lib-platform-pylib.CorrelationContext` | `print` / `logging.basicConfig` |
| Secrets resolution | `data-lib-platform-pylib.SecretsResolver` | boto3 Secrets Manager directly |
| Retry logic | `data-lib-platform-pylib.RetryPolicy` | custom retry loops |
| Event schemas | `data-lib-events` classes | hand-rolled dicts or JSON |
| Quality check wrappers | `data-lib-platform-pylib.GERunner` | raw Great Expectations context |

Library reference pages:
- atlas/repos/data-lib-platform-pylib.md
- atlas/repos/data-lib-events.md — if producing or consuming events
- atlas/dependency-map.md — public contracts

## Runbooks

- atlas/runbooks/lambda-failure-debugging.md
- atlas/runbooks/sqs-backlog-debugging.md

## Runtime rules

- Every Lambda invocation must be idempotent; retries are guaranteed. See `atlas/standards/aws-lambda.md`.

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`
