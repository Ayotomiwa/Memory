# dl-quality-checks-lambda

## Summary

Python Lambda triggered on `data.raw.landed` events. Runs declarative data quality checks (row counts, null rates, schema conformance, referential expectations) against the raw batch and either publishes `data.quality.validated` for good batches or routes bad batches to quarantine and pages the owning team.

## Type

- **Type**: Python Lambda
- **Language / tooling**: Python 3.12 / `uv` / `pytest`
- **Repo URL**: `gitlab.company.internal/data/dl-quality-checks-lambda`

## Responsibilities

- Consume `data.raw.landed` events from EventBridge.
- Load the declared check suite for the (source, dataset) combo from a config file in the repo.
- Run the checks via Great Expectations (or the team's wrapper over it — see [data-lib-platform-pylib](data-lib-platform-pylib.md)).
- Publish `data.quality.validated` on pass; emit `data.quality.rejected` on fail.
- Write a quality report to S3 alongside the batch.

## Connections

### Upstream
- [dl-ingestion-lambdas](dl-ingestion-lambdas.md) — emits `data.raw.landed`

### Downstream
- [curated-etl-glue](curated-etl-glue.md) — consumes `data.quality.validated`
- [lineage-service](lineage-service.md) — consumes both validated and rejected events
- On-call pager — bad batches above threshold

### Shared libraries
- [data-lib-platform-pylib](data-lib-platform-pylib.md)
- [data-lib-events](data-lib-events.md)

## Events / APIs

### Publishes
- `data.quality.validated`
- `data.quality.rejected`

### Consumes
- `data.raw.landed`

## AWS context

- **Lambda**: `dl-quality-checks-handler`
- **Queue**: `dl-quality-checks-events` (SQS subscription to the EventBridge rule)
- **DLQ**: `dl-quality-checks-dlq`
- **Stack**: `dl-quality-checks-lambda-<env>`
- **Log group**: `/aws/lambda/dl-quality-checks-handler`
- **Alarms**:
  - `quality-checks-errors` → [lambda-failure-debugging](../runbooks/lambda-failure-debugging.md)
  - `quality-checks-dlq-growth` → [sqs-backlog-debugging](../runbooks/sqs-backlog-debugging.md)
  - `quality-rejected-rate-high` → check upstream source health

Cross-reference: `AWS context`.

## Known gotchas

- Quality check configs are bundled into the Lambda artifact. A config-only change still requires a deploy — do not be surprised by the `dev` → `prod` lag.
- Great Expectations context initialization is slow; it is done at module scope to avoid cold-start pain, so holding mutable state there is a bug.
- Rejected batches are not reprocessed automatically. Manual replay is tracked in the `data.quality.rejected` S3 report.

## Related docs

- Flows: [raw-to-curated-flow](../flows/raw-to-curated-flow.md), [quality-rejection-flow](../flows/quality-rejection-flow.md)
- Standards: [python-services](../standards/python-services.md), [aws-lambda](../standards/aws-lambda.md), [event-contracts](../standards/event-contracts.md), [aws-testing](../standards/aws-testing.md)
- Runbooks: [lambda-failure-debugging](../runbooks/lambda-failure-debugging.md), [sqs-backlog-debugging](../runbooks/sqs-backlog-debugging.md)

## Claude routing

The local `CLAUDE.md` type template (`python-lambda`) covers mandatory pre-task reads. Additional reads by change type:

If adding a new check type:
- atlas/repos/data-lib-platform-pylib.md

If changing event schemas:
- atlas/standards/event-contracts.md
- atlas/dependency-map.md
- atlas/repos/data-lib-events.md
- atlas/repos/curated-etl-glue.md
- atlas/repos/lineage-service.md

## Validation expectations

- Local: `uv run pytest`
- Pre-merge: publish a synthetic `data.raw.landed` event in `dev`, confirm:
  - Expected `data.quality.validated` or `data.quality.rejected` observed
  - S3 quality report written
- Post-merge: see [aws-testing](../standards/aws-testing.md).
