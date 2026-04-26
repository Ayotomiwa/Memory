# Python services — standards

Conventions for Python services and Lambdas owned by this team.

Related: [[aws-lambda]], [[event-contracts]], [[observability]], [[aws-testing]]

## Packaging and tooling

- Prefer a single tool per repo: `uv` or `poetry` — the local `CLAUDE.md` declares which.
- Lock files are committed.
- Python version is pinned via `.python-version` or pyproject metadata.

## Structure

- Business logic in a `domain/` or `services/` module; adapters (HTTP, SQS, Lambda) in a separate module.
- Keep handlers thin: parse input, call domain, format output.
- Type hints required on public interfaces.

## Events

- Event schemas are defined in a shared Python library (tracked in [[shared-libraries]]), matching the Java contracts.
- Validate with `pydantic` or equivalent at the boundary.
- Any event contract change must follow [[event-contracts]] rules.

## Observability

- Use the shared observability library.
- Structured JSON logging by default; never `print`.
- See [[observability]].

## Testing

- `pytest` is the standard runner.
- Integration tests use real dependencies (LocalStack, Docker DB) where practical — see [[aws-testing]] for AWS-specific expectations.
- Do not mock AWS SDK calls in tests that exist to verify AWS behavior.

## Lambdas

- Python Lambdas follow the same rules as services, plus [[aws-lambda]].
- Handler module and function are named consistently across repos; the local `CLAUDE.md` records the pattern.

## Ownership

See [[ownership]].

## Starter sources

> Expand as staging material compiles in.
