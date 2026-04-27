# data-lib-platform-pylib

## Summary

Shared Python library used by every data-engineering Python runtime in the team: Lambdas, Glue jobs, and small CLI tools. Provides cross-cutting concerns so individual repos stay focused on business logic.

## Type

- **Type**: Python library (wheel published to internal PyPI)
- **Language / tooling**: Python 3.11+ / `uv` / `pytest`
- **Repo URL**: `gitlab.company.internal/data/data-lib-platform-pylib`

## Responsibilities

- Structured logging + correlation ID propagation.
- S3 helpers (partition-aware paths, safe writes, presigned URL generation).
- Secrets resolution (Secrets Manager / Parameter Store, with caching).
- Event publish/consume helpers (EventBridge + SQS) that use [data-lib-events](data-lib-events.md) schemas.
- Retry / backoff policies tuned for data-platform workloads.
- Great Expectations wrapper used by [dl-quality-checks-lambda](dl-quality-checks-lambda.md).
- Glue-specific adapters (Spark session setup, catalog helpers).

## Connections

### Consumers
- [dl-ingestion-lambdas](dl-ingestion-lambdas.md)
- [dl-quality-checks-lambda](dl-quality-checks-lambda.md)
- [curated-etl-glue](curated-etl-glue.md)

### Depends on
- [data-lib-events](data-lib-events.md) - event schemas
- Third-party: `boto3`, `great-expectations`, `pydantic`, `structlog`

## Events / APIs

### Public modules
- `data_platform.logging`
- `data_platform.events` (wraps [data-lib-events](data-lib-events.md))
- `data_platform.s3`
- `data_platform.secrets`
- `data_platform.retry`
- `data_platform.quality`
- `data_platform.glue`

## AWS context

This library is used **inside** AWS runtimes. It does not own AWS resources itself, but it interacts with:

- EventBridge buses defined in [datalake-cfn](datalake-cfn.md)
- Secrets Manager secrets defined per-consumer
- S3 buckets owned by [datalake-cfn](datalake-cfn.md)

## Known gotchas

- Glue bundles an older `boto3`. The `data_platform.s3` module works around two specific incompatibilities - look at the tests before pinning a newer `boto3`.
- `data_platform.retry` defaults to exponential backoff with jitter. It is **not** idempotency-aware; callers must still use deterministic keys and safe side effects.
- Lambdas import `data_platform` at module scope. Adding heavy imports to `__init__.py` will hurt every Lambda cold start in the fleet.
- The `data_platform.quality` wrapper caches the Great Expectations context per process. In Glue this is fine; in long-lived processes, reload manually after config changes.

## Related docs

- Standards: [python-services](../standards/python-services.md), [aws-lambda](../standards/aws-lambda.md), logging/metrics expectations, [event-contracts](../standards/event-contracts.md)
- Schema source: [data-lib-events](data-lib-events.md)
- Flows: [vendor-onboarding-flow](../flows/vendor-onboarding-flow.md), [quality-rejection-flow](../flows/quality-rejection-flow.md)

## Claude routing

1. This page
2. [dependency-map](../dependency-map.md)
3. [event-contracts](../standards/event-contracts.md) (if changing the events module)

If the change is a breaking API change, also read:
- [dependency-map](../dependency-map.md)
- Every consumer's page (to plan the rollout)

## Change risk

| Change type | Risk | Action |
|---|---|---|
| New public function | Low | Add tests, publish as minor version |
| Breaking API change | High | Deprecation dance: add new API, migrate consumers, remove old API in a later release |
| Bump third-party dep | Medium | Run the full test suite; validate in a Lambda and a Glue job in `dev` before releasing |

## Validation expectations

- Local: `uv run pytest`
- Pre-release: publish a pre-release wheel, install in one Lambda and one Glue job in `dev`, confirm behavior.
- Release: bump version, tag, CI publishes. Consumers upgrade at their own pace unless the change is a security fix.
