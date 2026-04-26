# quality-checks-lambda

## Summary

Python Lambda triggered on `data.raw.landed` events. Runs declarative data quality checks (row counts, null rates, schema conformance, referential expectations) against the raw batch and either publishes `data.quality.validated` for good batches or routes bad batches to quarantine and pages the owning team.

## Type

- **Type**: Python Lambda
- **Language / tooling**: Python 3.12 / `uv` / `pytest`
- **Repo URL**: `gitlab.company.internal/data/quality-checks-lambda`

## Responsibilities

- Consume `data.raw.landed` events from EventBridge.
- Load the declared check suite for the (source, dataset) combo from a config file in the repo.
- Run the checks via Great Expectations (or the team's wrapper over it — see [[data-platform-pylib]]).
- Publish `data.quality.validated` on pass; emit `data.quality.rejected` on fail.
- Write a quality report to S3 alongside the batch.

## Connections

### Upstream
- [[ingestion-lambdas]] — emits `data.raw.landed`

### Downstream
- [[curated-etl-glue]] — consumes `data.quality.validated`
- [[lineage-service]] — consumes both validated and rejected events
- On-call pager — bad batches above threshold

### Shared libraries
- [[data-platform-pylib]]
- [[data-events]]

## Events / APIs

### Publishes
- `data.quality.validated`
- `data.quality.rejected`

### Consumes
- `data.raw.landed`

## AWS context

- **Lambda**: `quality-checks-handler`
- **Queue**: `quality-checks-events` (SQS subscription to the EventBridge rule)
- **DLQ**: `quality-checks-dlq`
- **Stack**: `quality-checks-lambda-<env>`
- **Log group**: `/aws/lambda/quality-checks-handler`
- **Alarms**:
  - `quality-checks-errors` → [[lambda-failure-debugging]]
  - `quality-checks-dlq-growth` → [[sqs-backlog-debugging]]
  - `quality-rejected-rate-high` → check upstream source health

Cross-reference: [[aws-resources]].

## Known gotchas

- Quality check configs are bundled into the Lambda artifact. A config-only change still requires a deploy — do not be surprised by the `dev` → `prod` lag.
- Great Expectations context initialization is slow; it is done at module scope to avoid cold-start pain, so holding mutable state there is a bug.
- Rejected batches are not reprocessed automatically. Manual replay is tracked in the `data.quality.rejected` S3 report.

## Related docs

- Flows: [[raw-to-curated-flow]]
- Standards: [[python-services]], [[aws-lambda]], [[event-contracts]], [[aws-testing]]
- Runbooks: [[lambda-failure-debugging]], [[sqs-backlog-debugging]]
- Concepts: [[idempotency]]

## Claude routing

The local `CLAUDE.md` type template (`python-lambda`) covers mandatory pre-task reads. Additional reads by change type:

If adding a new check type:
- atlas/repos/data-platform-pylib.md

If changing event schemas:
- atlas/standards/event-contracts.md
- atlas/repo-map/dependency-map.md
- atlas/repos/data-events.md
- atlas/repos/curated-etl-glue.md
- atlas/repos/lineage-service.md

## Validation expectations

- Local: `uv run pytest`
- Pre-merge: publish a synthetic `data.raw.landed` event in `dev`, confirm:
  - Expected `data.quality.validated` or `data.quality.rejected` observed
  - S3 quality report written
- Post-merge: see [[aws-testing]].
