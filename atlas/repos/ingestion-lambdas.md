# ingestion-lambdas

## Summary

Collection of Python Lambdas that pull raw data from upstream APIs (vendors, partner SFTP, internal webhooks) into the S3 **raw zone** of the data lake. Each ingestion is a separate Lambda with its own schedule or trigger, sharing common code via [[data-platform-pylib]].

## Type

- **Type**: Python Lambda (multi-function repo)
- **Language / tooling**: Python 3.12 / `uv` / `pytest`
- **Repo URL**: `gitlab.company.internal/data/ingestion-lambdas`

## Responsibilities

- Pull raw data from upstream sources on schedule or webhook.
- Write raw files to the S3 raw zone following the partition convention (`s3://raw/<source>/<dataset>/ingest_date=YYYY-MM-DD/`).
- Publish a `data.raw.landed` event per successful batch.
- Route failed ingests to the quarantine bucket and alarm.

## Connections

### Upstream (triggers)
- EventBridge Scheduler rules defined in [[datalake-cfn]]
- Webhook API Gateway routes defined in [[datalake-cfn]]
- External vendor APIs (not a repo — see "Vendor APIs" section below)

### Downstream (who consumes what this repo produces)
- [[quality-checks-lambda]] — consumes `data.raw.landed`
- [[lineage-service]] — consumes `data.raw.landed` for lineage tracking

### Shared libraries
- [[data-platform-pylib]] — logging, correlation IDs, S3 helpers, secrets, retry policy
- [[data-events]] — schema definitions for `data.raw.landed`

## Events / APIs

### Publishes
- `data.raw.landed` — emitted on successful ingest of a batch

### Consumes
- _None directly — triggers are schedules and webhooks_

## AWS context

- **Lambdas**: one per source, named `ingest-<source>-<dataset>` (e.g., `ingest-vendor-a-transactions`)
- **Queues**: `ingestion-dlq` (shared DLQ)
- **Buckets**: `raw-zone-<env>`, `ingestion-quarantine-<env>` (owned by [[datalake-cfn]])
- **Stack**: `ingestion-lambdas-<env>`
- **Log groups**: `/aws/lambda/ingest-*`
- **Alarms**:
  - `ingestion-errors-<source>` → [[lambda-failure-debugging]]
  - `ingestion-quarantine-growth` → check quarantine bucket
  - `ingestion-missed-schedule` → scheduler failure

Cross-reference: [[aws-resources]].

## Vendor APIs

Credentials for upstream APIs are resolved at runtime from Secrets Manager via [[data-platform-pylib]]. Vendor quirks (rate limits, pagination, auth flows) are documented per-vendor in `docs/vendors/` inside the repo — not duplicated here.

## Known gotchas

- Some vendors return `200 OK` with an error payload. Always validate the response body structure before declaring success.
- Webhook ingest deduplication relies on the upstream message ID; if the vendor changes that ID format, we silently double-ingest.
- Partition by `ingest_date` (date we ingested), **not** event date — backfills break otherwise.
- Lambda memory is tuned per dataset; bumping it in CloudFormation requires redeploy even if `ConcurrentExecutions` stays the same.

## Related docs

- Flows: [[raw-to-curated-flow]]
- Standards: [[python-services]], [[aws-lambda]], [[event-contracts]], [[aws-testing]], [[observability]]
- Runbooks: [[lambda-failure-debugging]], [[sqs-backlog-debugging]]
- Infra: [[datalake-cfn]]

## Claude routing

The local `CLAUDE.md` type template (`python-lambda`) covers mandatory pre-task reads. Additional reads by change type:

If changing `data.raw.landed` schema:
- atlas/standards/event-contracts.md
- atlas/repo-map/dependency-map.md
- atlas/repos/data-events.md
- atlas/repos/quality-checks-lambda.md
- atlas/repos/lineage-service.md

If adding a new ingestion source:
- atlas/repos/data-platform-pylib.md
- atlas/repos/datalake-cfn.md

## Validation expectations

- Local: `uv run pytest`
- Pre-merge: deploy to `dev`, trigger the affected ingest once, confirm:
  - Lambda outcome log shows `status=ok`
  - Raw file landed at the expected S3 key
  - `data.raw.landed` event observed by [[quality-checks-lambda]] in `dev`
- Post-merge: see [[aws-testing]].
