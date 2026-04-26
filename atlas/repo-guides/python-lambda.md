# Type: Python Lambda

## Read before any implementation task

- atlas/standards/python-services.md
- atlas/standards/aws-lambda.md
- atlas/standards/aws-testing.md
- atlas/standards/observability.md

## Shared libraries — use these, not raw equivalents

| Task | Use | Not |
|---|---|---|
| S3 reads/writes | `data-platform-pylib.S3Client` | boto3 S3 directly |
| Structured logging / correlation ID | `data-platform-pylib.CorrelationContext` | `print` / `logging.basicConfig` |
| Secrets resolution | `data-platform-pylib.SecretsResolver` | boto3 Secrets Manager directly |
| Retry logic | `data-platform-pylib.RetryPolicy` | custom retry loops |
| Event schemas | `data-events` classes | hand-rolled dicts or JSON |
| Quality check wrappers | `data-platform-pylib.GERunner` | raw Great Expectations context |

Library reference pages:
- atlas/repos/data-platform-pylib.md
- atlas/repos/data-events.md — if producing or consuming events
- atlas/repo-map/shared-libraries.md — public contracts

## Runbooks

- atlas/runbooks/lambda-failure-debugging.md
- atlas/runbooks/sqs-backlog-debugging.md

## Concepts

- atlas/concepts/idempotency.md — every Lambda invocation must be idempotent; retries are guaranteed

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any runtime-affecting change
- `/repo-impact` — list affected repos before changing an event schema or shared library

Full catalog: `claude-assets/skills-catalog.md`

## Related

[[python-services]] | [[aws-lambda]] | [[aws-testing]] | [[observability]] | [[data-platform-pylib]] | [[data-events]] | [[shared-libraries]] | [[lambda-failure-debugging]] | [[sqs-backlog-debugging]] | [[idempotency]]
