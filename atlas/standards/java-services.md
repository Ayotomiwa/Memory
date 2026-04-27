# Java services — standards

Conventions for Java services owned by this team.

Related: [aws-lambda](aws-lambda.md), [event-contracts](event-contracts.md), [aws-testing](aws-testing.md)

## Build and test

- Build tool: Gradle (unless a repo's local `CLAUDE.md` says otherwise).
- Standard commands:
  - `./gradlew test`
  - `./gradlew check`
  - `./gradlew build`
- Every service's local `CLAUDE.md` must list these (or its overrides) verbatim.

## Structure

- Public API surface minimal; prefer package-private for internal collaborators.
- Domain types should not depend on transport types (HTTP, SQS, etc.).
- No business logic in controllers/handlers.

## Events

- Event schemas live in [data-lib-events](../repos/data-lib-events.md), never per-service.
- Producers use the schema library types; do not hand-roll JSON.
- Consumers validate with the schema library before acting.
- Any event contract change must follow [event-contracts](event-contracts.md) rules.

## Logging and metrics

- Use the shared logging/metrics library.
- Every request/message processed emits at minimum: `correlationId`, `messageId`, outcome, duration.

## Testing

- Unit tests cover business logic.
- Integration tests hit a real local dependency when practical (DB, LocalStack, etc.).
- Do **not** mock database layers in integration tests without a good reason — mock-vs-real divergence is a recurring source of incidents.
- For AWS-touching services, see [aws-testing](aws-testing.md) for the expected runtime validation steps.

## Error handling

- No blanket `catch (Exception e)` unless followed by a structured log and a rethrow or explicit swallow reason.
- Retries belong in the transport or framework layer, not the business logic.

## Ownership

- Every Java service has an owning team listed in the repo page.
- A repo without an owning team is a bug; flag it to the platform team.

## Starter sources

> This page is a seed. Expand as staging material compiles in. Cite raw sources in `staging/` where useful.
