# curated-etl-glue

## Summary

PySpark Glue jobs that transform validated raw data into the **curated zone** of the data lake. Organized per domain (e.g., `transactions`, `customers`, `products`). Jobs are triggered by `data.quality.validated` events via a Glue workflow or EventBridge-initiated job run.

## Type

- **Type**: AWS Glue (PySpark) jobs
- **Language / tooling**: Python 3.11 / Glue 4.0 / PySpark
- **Repo URL**: `gitlab.company.internal/data/curated-etl-glue`

## Responsibilities

- Read validated raw batches from S3.
- Apply curation logic: deduplication, schema standardization, SCD handling for dimensions, unit normalization.
- Write curated tables (Parquet) partitioned per domain spec.
- Update the Glue Data Catalog.
- Publish `data.curated.published` on successful job completion.

## Connections

### Upstream
- [dl-quality-checks-lambda](dl-quality-checks-lambda.md) — emits `data.quality.validated`

### Downstream
- [analytics-api](analytics-api.md) — reads curated tables
- [lineage-service](lineage-service.md) — consumes `data.curated.published`
- Downstream BI / analyst tooling (Athena, QuickSight) — not repos

### Shared libraries
- [data-lib-platform-pylib](data-lib-platform-pylib.md) — imported into Glue jobs via the Glue `--additional-python-modules` path; see the repo's `Makefile` for the upload step
- [data-lib-events](data-lib-events.md)

## Events / APIs

### Publishes
- `data.curated.published`

### Consumes
- `data.quality.validated` (via Glue workflow trigger)

## AWS context

- **Glue jobs**: `curated-<domain>-<dataset>` (e.g., `curated-finance-transactions`)
- **Glue workflows**: `curated-<domain>-workflow`
- **Glue triggers**: EventBridge-backed triggers subscribing to `data.quality.validated`
- **Buckets**: `curated-zone-<env>`, `raw-zone-<env>` (read-only)
- **Stack**: `curated-etl-glue-<env>`
- **Catalog databases**: `curated_<domain>_<env>`
- **Alarms**:
  - `glue-job-failures` per domain
  - `glue-job-runtime-exceeded` per domain

Cross-reference: `AWS context`.

## Known gotchas

- Glue job parameters are merged at runtime from (workflow default args) + (trigger args) + (job-level args). Order matters; a workflow override wins over a job-level default.
- Uploading a new `data-lib-platform-pylib` wheel requires re-uploading for each Glue job's `--additional-python-modules` — no automatic propagation.
- Job bookmarks misbehave on S3 partitions added out of order (late-arriving `ingest_date` partitions). Bookmark reset is the standard workaround.
- Spark schema inference on the raw zone is dangerous — always pull the schema from the Glue Data Catalog or an explicit StructType.

## Related docs

- Flows: [raw-to-curated-flow](../flows/raw-to-curated-flow.md), [dataset-query-flow](../flows/dataset-query-flow.md), [event-schema-rollout-flow](../flows/event-schema-rollout-flow.md)
- Standards: [python-services](../standards/python-services.md), [event-contracts](../standards/event-contracts.md), [aws-testing](../standards/aws-testing.md)
- Infra: [datalake-cfn](datalake-cfn.md)

## Claude routing

The local `CLAUDE.md` type template (`glue-job`) covers mandatory pre-task reads. Additional reads by change type:

If changing `data.curated.published` schema or output event:
- atlas/standards/event-contracts.md
- atlas/dependency-map.md
- atlas/repos/data-lib-events.md

If changing catalog schema or curated table structure:
- atlas/repos/datalake-cfn.md
- atlas/repos/analytics-api.md

## Validation expectations

- Local: unit tests run against small fixture Parquet files (`uv run pytest`); integration tests run the job in Glue `dev` via `make run-dev JOB=<name>`.
- Pre-merge: run the job in `dev` with a synthetic `data.quality.validated` event, confirm curated output and `data.curated.published`.
- Post-merge: watch Glue job runs and alarm dashboard per [aws-testing](../standards/aws-testing.md).
