# example-service

> **Template page.** Copy this file to `atlas/repos/<repo>.md` and fill it in.
> For real-world filled-in examples, see [[ingestion-lambdas]], [[curated-etl-glue]], [[data-platform-pylib]], [[datalake-cfn]].

## Summary

One or two sentences on what this repo does and why it exists.

## Type

- **Type**: Java service | Python service | Lambda | library | infrastructure
- **Language / tooling**: e.g., Java 21 / Gradle
- **Repo URL**: `<gitlab URL>`

## Responsibilities

- Bullet list of top 3–5 responsibilities.

## Connections

### Upstream (who calls / sends to this repo)
- `<upstream-repo>` — short description

### Downstream (who this repo calls / sends to)
- `<downstream-repo>` — short description

### Shared libraries
- [[data-events]] — event schemas (replace with actual libraries used)
- [[data-platform-pylib]] — utilities (replace or remove if not applicable)

## Events / APIs

### Publishes
- `<event-name>`

### Consumes
- `<event-name>`

### HTTP / gRPC endpoints
- `GET /<path>` — consumed by `<caller>`

## AWS context

- **Lambdas**: `<function-name>`
- **Queues**: `<queue-name>`, `<dlq-name>`
- **Stack**: `<stack-name>-<env>`
- **Log group**: `/aws/lambda/<function-name>`
- **Alarms**:
  - `<alarm-name>` → [[lambda-failure-debugging]]
  - `<alarm-name>` → [[sqs-backlog-debugging]]

Cross-reference: [[aws-resources]].

## Known gotchas

- Short, bullet-sized warnings. Update this section aggressively — it is the highest-value part of the page.

## Related docs

- Flows: `<flow-page>`
- Standards: [[java-services]], [[event-contracts]], [[aws-testing]]
- Runbooks: [[lambda-failure-debugging]], [[sqs-backlog-debugging]]

## Claude routing

The local `CLAUDE.md` type template covers mandatory pre-task reads. Additional reads by change type:

If changing event schemas:
- atlas/standards/event-contracts.md
- atlas/repo-map/dependency-map.md
- atlas/repos/data-events.md

If changing AWS runtime behavior:
- atlas/runbooks/lambda-failure-debugging.md

If change crosses repos, read the downstream repo pages listed in Connections above.

## Validation expectations

- Local: `<test command from local CLAUDE.md>`.
- Pre-merge: deploy to `dev`, run the trigger path, confirm outcome log.
- Post-merge: see [[aws-testing]].
