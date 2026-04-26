# Idempotency

## What it means here

An operation is **idempotent** if running it twice with the same input produces the same final state as running it once. In our data platform, every Lambda and Glue job must be idempotent, because every invocation may be retried.

Related: [[aws-lambda]], [[event-contracts]], [[quality-checks-lambda]], [[curated-etl-glue]], [[lineage-service]], [[data-platform-pylib]]

## Why we care

- Lambdas retry on error (SQS, EventBridge, DLQ).
- Glue workflow triggers can refire on the same event.
- Network failures cause SDKs to retry transparently.
- Replays (disaster recovery, backfills) reprocess the same events on purpose.

If any step is non-idempotent, retries corrupt data.

## The idempotency key

Each event carries an ID that downstream steps treat as the idempotency key:

- `data.raw.landed` → batch ID (source + dataset + ingest_date + sequence)
- `data.quality.validated` → batch ID (same as above)
- `data.curated.published` → job run ID + output partition

The ID lives in [[data-events]] schemas. Do not invent ad-hoc keys in business code.

## Patterns we use

### Lambda side
- Before processing, check a short-lived store (DynamoDB conditional write, S3 "done" marker) keyed by the idempotency key. Skip if already done.
- Writes to S3 use deterministic keys so a retry overwrites with the same content (not an append).

### Glue side
- Job bookmarks are **not** a substitute for idempotency — use explicit output partitioning and overwrite the target partition fully.
- Never append; always overwrite the target partition based on the input batch.

### Lineage side
- [[lineage-service]] uses (event ID + event type) as a primary key so duplicate deliveries don't create duplicate edges.

## Anti-patterns

- Using `now()` in output keys — breaks retry determinism.
- Using auto-incrementing database IDs in business-level identifiers — couples idempotency to write ordering.
- Sending notifications (email, pager) without a dedup key — retries page twice.
- Relying on SQS visibility timeout as an idempotency mechanism.

## How to test

- For every handler, have at least one test that calls the handler twice with the same input and asserts the output is unchanged.
- For Glue jobs, rerun the job with the same input in `dev` and compare the curated output partition.

## Related failures

Retry-without-idempotency bugs show up as:

- Duplicate rows in curated tables.
- Multiple pager alerts for a single bad batch.
- Lineage graph with parallel edges between the same nodes.

These are worth capturing in `staging/incidents/` as they happen.
