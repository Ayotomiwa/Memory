# Python services — standards

Conventions for Python services and Lambdas owned by this team.

Related: [aws-lambda](aws-lambda.md), [event-contracts](event-contracts.md), [aws-testing](aws-testing.md)

## Packaging and tooling

- Prefer a single tool per repo: `uv` or `poetry` — the local `CLAUDE.md` declares which.
- Lock files are committed.
- Python version is pinned via `.python-version` or pyproject metadata.

## Structure

- Business logic in a `domain/` or `services/` module; adapters (HTTP, SQS, Lambda) in a separate module.
- Keep handlers thin: parse input, call domain, format output.
- Type hints required on public interfaces.

## Events

- Event schemas are defined in a shared Python library (tracked in [dependency-map](../dependency-map.md)), matching the Java contracts.
- Validate with `pydantic` or equivalent at the boundary.
- Any event contract change must follow [event-contracts](event-contracts.md) rules.

## Logging and metrics

- Use the shared logging/metrics library.
- Structured JSON logging by default; never `print`.

## Testing

- `pytest` is the standard runner.
- Integration tests use real dependencies (LocalStack, Docker DB) where practical — see [aws-testing](aws-testing.md) for AWS-specific expectations.
- Do not mock AWS SDK calls in tests that exist to verify AWS behavior.

## Lambdas

- Python Lambdas follow the same rules as services, plus [aws-lambda](aws-lambda.md).
- Handler module and function are named consistently across repos; the local `CLAUDE.md` records the pattern.

## Ownership

See the repo page.

## Starter sources

> Expand as staging material compiles in.
