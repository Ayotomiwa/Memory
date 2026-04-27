# lineage-service

## Summary

Java service that consumes every data-platform event (`data.raw.landed`, `data.quality.validated`, `data.quality.rejected`, `data.curated.published`) and maintains a queryable lineage graph: which raw batch became which curated rows, with quality and timing metadata. Exposes an HTTP API for analysts and auditors.

## Type

- **Type**: Java service
- **Language / tooling**: Java 21 / Gradle / Postgres + Neo4j (graph backend)
- **Repo URL**: `gitlab.company.internal/data/lineage-service`

## Responsibilities

- Subscribe to the `data-lib-events-bus` and persist each event into the lineage store.
- Build graph edges linking raw → curated records across jobs.
- Serve lineage queries via HTTP: "where did curated row X come from?", "what downstream tables depend on raw batch Y?".

## Connections

### Upstream
- EventBridge bus `data-lib-events-bus` (owned by [datalake-cfn](datalake-cfn.md))
- Publishers: [dl-ingestion-lambdas](dl-ingestion-lambdas.md), [dl-quality-checks-lambda](dl-quality-checks-lambda.md), [curated-etl-glue](curated-etl-glue.md)

### Downstream
- [analytics-api](analytics-api.md) — calls lineage API for curated table provenance
- BI / analyst tools — via HTTP API

### Shared libraries
- [data-lib-events](data-lib-events.md)
- Shared Java logging/metrics library

## Events / APIs

### Publishes
- _None — read model only_

### Consumes
- `data.raw.landed`
- `data.quality.validated`
- `data.quality.rejected`
- `data.curated.published`

### HTTP
- `GET /lineage/record/{curatedRecordId}` — upstream lineage
- `GET /lineage/batch/{rawBatchId}/downstream` — downstream impact

## AWS context

- **Compute**: ECS Fargate service (not Lambda — lineage queries need persistent connections)
- **Queues**: `lineage-events`, `lineage-dlq`
- **Databases**: RDS Postgres + Neo4j Aura
- **Stack**: `lineage-service-<env>`
- **Alarms**:
  - `lineage-event-lag` — consumer lag on the SQS subscription
  - `lineage-dlq-growth`
  - `lineage-api-5xx`

Cross-reference: `AWS context`.

## Known gotchas

- Event ordering is not guaranteed. A `data.curated.published` event may arrive before the matching `data.quality.validated`. Store both and reconcile asynchronously.
- Neo4j writes are expensive. Batch edges by (job run, partition) rather than one write per record.
- The Postgres schema evolves via Liquibase; schema drift between `dev` and `prod` has bitten us before — always verify migration state after deploy.

## Related docs

- Flows: [raw-to-curated-flow](../flows/raw-to-curated-flow.md), [quality-rejection-flow](../flows/quality-rejection-flow.md), [dataset-query-flow](../flows/dataset-query-flow.md)
- Standards: [java-services](../standards/java-services.md), [event-contracts](../standards/event-contracts.md), logging/metrics expectations
- Runbooks: [sqs-backlog-debugging](../runbooks/sqs-backlog-debugging.md)

## Claude routing

The local `CLAUDE.md` type template (`java-service`) covers mandatory pre-task reads. Additional reads by change type:

If touching event handling:
- atlas/standards/event-contracts.md
- atlas/repos/data-lib-events.md
- atlas/standards/aws-lambda.md

If touching the Postgres schema (Liquibase migrations):
- Verify migration state matches between `dev` and `prod` before deploying — schema drift is a known gotcha for this repo.

## Validation expectations

- Local: `./gradlew check`
- Pre-merge: deploy to `dev`, replay a known raw batch, confirm lineage API returns the expected graph.
- Post-merge: see [aws-testing](../standards/aws-testing.md) plus the service-specific alarms above.
