# data-lib-events

## Summary

Shared schema library for data-platform events (`data.raw.landed`, `data.quality.validated`, `data.quality.rejected`, `data.curated.published`). Published as both a Python wheel and a Java artifact so every producer and consumer imports the same schema.

## Type

- **Type**: Shared schema library (Python + Java)
- **Language / tooling**: Python 3.11 / Java 21 / Pydantic + Jackson
- **Repo URL**: `gitlab.company.internal/data/data-lib-events`

## Responsibilities

- Define the canonical schema for each data-platform event.
- Publish Python + Java artifacts, version-aligned, so producers and consumers stay in lockstep.
- Enforce the compatibility rules in [event-contracts](../standards/event-contracts.md) in CI.

## Connections

### Producers
- [dl-ingestion-lambdas](dl-ingestion-lambdas.md) — `data.raw.landed`
- [dl-quality-checks-lambda](dl-quality-checks-lambda.md) — `data.quality.validated`, `data.quality.rejected`
- [curated-etl-glue](curated-etl-glue.md) — `data.curated.published`

### Consumers
- [dl-quality-checks-lambda](dl-quality-checks-lambda.md)
- [curated-etl-glue](curated-etl-glue.md)
- [lineage-service](lineage-service.md)

### Depends on
- _(no runtime deps beyond Pydantic / Jackson)_

## Events / APIs

### Events defined here
- `data.raw.landed`
- `data.quality.validated`
- `data.quality.rejected`
- `data.curated.published`

## Known gotchas

- Enum additions must be published as additive changes first, then consumers upgrade, then producers emit the new value. Skipping that order breaks consumers that use exhaustive matching.
- The Python and Java artifacts are versioned together. Bumping one without the other is a release bug — CI should catch it but has missed edge cases.
- Timestamps are always ISO-8601 with `Z`. Any code serializing local time is a bug.

## Related docs

- Standards: [event-contracts](../standards/event-contracts.md), [java-services](../standards/java-services.md), [python-services](../standards/python-services.md)
- Flows: [event-schema-rollout-flow](../flows/event-schema-rollout-flow.md)
- Map: [dependency-map](../dependency-map.md)
- Event IDs drive downstream idempotency keys.

## Claude routing

1. This page
2. [event-contracts](../standards/event-contracts.md)
3. [dependency-map](../dependency-map.md) (for impact analysis)
4. Each consumer's page if the change is breaking

## Change risk

Treat every change as potentially cross-team. See the rollout procedure in [event-contracts](../standards/event-contracts.md).

## Validation expectations

- Local: `uv run pytest` + `./gradlew test`
- Pre-release: publish both artifacts; dry-run import in at least one Python and one Java consumer.
- Post-release: observe consumer logs in `dev` for at least one cycle before tagging a production release.
