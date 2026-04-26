# Shared libraries

Libraries used by more than one service. Changes here can break multiple consumers.

Related: [[repo-catalog]], [[dependency-map]], [[event-contracts]]

## Libraries

### [[data-platform-pylib]]
- **Purpose**: Cross-cutting Python utilities: logging, correlation IDs, S3 helpers, secrets, retry, Great Expectations wrapper, Glue adapters.
- **Consumers**: [[ingestion-lambdas]], [[quality-checks-lambda]], [[curated-etl-glue]]
- **Change risk**: Medium-to-High - a breaking API change forces every consumer to upgrade. Coordinate via [[dependency-map]].
- **Public contract** (external consumers may rely on these): `S3Client`, `CorrelationContext`, `GERunner`, `RetryPolicy`, `SecretsResolver`, `GlueAdapter`
- **Internal** (do not rely on outside the library): `_http_utils`, `_glue_internals`, `_auth_helpers`

### [[data-events]]
- **Purpose**: Shared schemas (Python + Java) for the team's data events.
- **Consumers**: every event producer and consumer - see [[dependency-map]] for the per-event list.
- **Change risk**: High - breaking schema changes can silently break downstream consumers. Follow [[event-contracts]] rules.
- **Public contract**: all top-level event classes and their documented fields. Internal envelope helpers are not part of the public contract.
- **Note**: For field-level usage per consumer, see [[usage-summaries]].

### Shared Java observability library _(external to the team's catalog)_
- **Purpose**: Structured logging, metrics helpers, correlation ID propagation for Java services.
- **Consumers**: [[lineage-service]], [[analytics-api]]
- **Change risk**: Medium - managed outside this repo's scope; document upgrades in `staging/mr-summaries/`.
- **Public contract**: managed upstream; treat all public methods as part of the contract.

## Before changing a shared library

1. Identify consumers from this page.
2. Check the library's **Public contract** section above to determine whether your change is to a public or internal surface.
   - Internal change -> likely safe; verify no consumer has reached in via reflection or similar.
   - Public contract change -> proceed to step 3.
3. For each consumer, read its local `CLAUDE.md` - `Dependencies and usage` section - to confirm whether it uses the specific class, method, or field being changed. See [[usage-summaries]] for a collected view.
4. If consumers aren't listed here, grep the team's repos and update this page.
5. For breaking changes, follow the deprecation dance from [[event-contracts]] (for schemas) or the standard deprecate-then-remove pattern (for code APIs).
6. Coordinate the rollout in `staging/mr-summaries/`.

## Adding a new shared library

1. Add a section above.
2. Create `atlas/repos/<library-name>.md`.
3. Document the intended consumers before publishing the library.
