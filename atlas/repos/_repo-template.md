# Repo page template

Copy this file to `atlas/repos/<repo-name>.md` and fill it in. One page should cover one repo. Name the page after the repo, not `README.md`.

## Summary

One or two sentences on what this repo does and why it exists.

## Type

- **Type**: Java service | Python service | Lambda | Glue job | library | infrastructure
- **Language / tooling**: e.g., Java 21 / Gradle
- **Repo URL**: `<gitlab URL>`
- **Owner**: `<team name>`

## Responsibilities

- Bullet list of top 3-5 responsibilities.

## Connections

### Upstream
- `<upstream repo or external system>` - short description

### Downstream
- `<downstream repo or external system>` - short description

### Shared libraries
- `<shared-library-name>` - which parts are used

## Events / APIs

### Publishes
- `<event-name>` - which fields

### Consumes
- `<event-name>` - which fields actually read

### HTTP / gRPC endpoints
- `<METHOD /path>` - consumed by `<caller>`

## AWS context

- **Lambdas**: `<function-name>`
- **Queues**: `<queue-name>`, `<dlq-name>`
- **Stack**: `<stack-name>-<env>`
- **Log group**: `/aws/lambda/<function-name>`
- **Alarms**:
  - `<alarm-name>` - `<runbook or response notes>`

## Known gotchas

- Short, bullet-sized warnings. Update this section aggressively; it is the highest-value part of the page.

## Related docs

- Flows: `<flow-page>`
- Standards: `<standard-page>`
- Runbooks: `<runbook-page>`

## Claude routing

The local `CLAUDE.md` type guide covers mandatory pre-task reads. Add only repo-specific routing here.

If changing event schemas:
- `atlas/standards/event-contracts.md`
- `atlas/dependency-map.md`
- `<event schema repo page>`

If changing AWS runtime behavior:
- `<relevant runbook path>`

If the change crosses repos, read the downstream repo pages listed in Connections above.

## Validation expectations

- Local: `<test command from local CLAUDE.md>`.
- Pre-merge: deploy to `dev`, run the trigger path, confirm outcome log.
- Post-merge: `<post-merge checks or monitoring notes>`.

## Naming and maintenance

- File: `<repo-name>.md` - match the repo name exactly.
- Link text: `<repo-name>`.
- Optional sections: Alerts, deployment notes, environment-specific quirks.
- If a single page exceeds about 300-400 lines, split supporting detail into `connections.md`, `aws.md`, or `known-gotchas.md` under `atlas/repos/<repo-name>/`.
