# analytics-api

## Summary

Java HTTP service exposing curated data for downstream product and analytics consumers. Queries the Glue Data Catalog via Athena, caches hot queries, and enforces row/column-level access controls.

## Type

- **Type**: Java service
- **Language / tooling**: Java 21 / Gradle
- **Repo URL**: `gitlab.company.internal/data/analytics-api`

## Responsibilities

- Expose curated datasets over HTTP (`/datasets/{name}/query`) and Parquet (`/datasets/{name}/export`).
- Translate public query DSL into Athena SQL.
- Enforce per-tenant data access rules.
- Call [[lineage-service]] to annotate responses with provenance.

## Connections

### Upstream (callers)
- Internal product services
- Analyst tooling

### Downstream
- [[curated-etl-glue]] — indirectly, via reading curated tables
- [[lineage-service]] — called for provenance metadata
- AWS Athena (managed service)

### Shared libraries
- Shared Java observability library

## Events / APIs

### Publishes
- _None_

### Consumes
- _None directly — pulls data on demand from the Glue catalog / Athena_

### HTTP
- `POST /datasets/{name}/query`
- `GET /datasets/{name}/export?partition=...`

## AWS context

- **Compute**: ECS Fargate service
- **IAM**: read-only role into [[datalake-cfn]] catalog + curated bucket
- **Stack**: `analytics-api-<env>`
- **Alarms**:
  - `analytics-api-5xx`
  - `athena-query-failures`
  - `cache-miss-rate-high`

Cross-reference: [[aws-resources]].

## Known gotchas

- Athena concurrency limits are per-workgroup. The service uses its own workgroup so it does not compete with ad-hoc analyst queries.
- Curated table schema changes can break query validation mid-request. Always coordinate with [[curated-etl-glue]] on breaking schema changes.
- Access rules are cached aggressively. Invalidation is event-driven; an access-rule change that isn't accompanied by the invalidation event will appear "stuck" in production.

## Related docs

- Flows: [[raw-to-curated-flow]]
- Standards: [[java-services]], [[observability]]
- Upstream data: [[curated-etl-glue]], [[lineage-service]]

## Claude routing

The local `CLAUDE.md` type template (`java-service`) covers mandatory pre-task reads. Additional reads by change type:

If touching curated table queries or schema:
- atlas/repos/curated-etl-glue.md

If touching access control rules:
- Note: rules are cached aggressively; changes require the invalidation event or the update appears stuck in production.

## Validation expectations

- Local: `./gradlew check`
- Pre-merge: deploy to `dev`, run the acceptance query suite against a known curated dataset, confirm latency and correctness.
- Post-merge: watch 5xx + Athena failure alarms.
