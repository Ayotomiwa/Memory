# AWS Lambda — standards

Conventions for Lambdas owned by this team. Language-agnostic; see [java-services](java-services.md) or [python-services](python-services.md) for language specifics.

Related: [cloudformation](cloudformation.md), [aws-testing](aws-testing.md), [lambda-failure-debugging](../runbooks/lambda-failure-debugging.md)

## Design

- One Lambda = one responsibility. Don't multiplex unrelated work into one function.
- Handlers are thin: parse, validate, delegate to a tested domain function, return.
- Cold-start-sensitive code (SDK clients, heavy imports) initialized at module scope, not per invocation.

## Retries and idempotency

- Assume every invocation may be retried. Every Lambda must be idempotent.
- Use deterministic idempotency keys from the triggering event or business object; do not invent ad-hoc keys in handler code.
- Before processing side effects, use a short-lived dedup store such as a DynamoDB conditional write or S3 "done" marker when duplicate delivery would corrupt state.
- Writes to S3 use deterministic keys so a retry overwrites with the same content, not an append.
- Anti-patterns: `now()` in output keys, auto-incrementing database IDs as business identifiers, notification side effects without a dedup key, and relying on SQS visibility timeout as the idempotency mechanism.
- Test every handler that processes events or queues by invoking it twice with the same input and asserting the output state is unchanged.
- For SQS-triggered Lambdas, understand [partial batch failure](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html) and return `batchItemFailures` correctly.

## Timeouts

- Default: set Lambda timeout to `p99 duration * 3` or a reasoned value; never leave at the account default.
- Upstream caller timeouts must exceed Lambda timeout plus expected queue latency.

## Environment variables

- Secrets go through Secrets Manager or Parameter Store, not plain env vars.
- Config env vars are documented in the repo's CloudFormation template and mirrored in `atlas/repos/<repo>.md`.

## Observability

- Structured JSON logs only.
- Every log line carries: `requestId` (Lambda), `correlationId` (business), `messageId` (event).
- Emit a single "outcome" log per invocation with `status=ok|error`, `durationMs`, and error details if any.

## Error handling

- Unrecoverable errors: let them throw — Lambda will log and retry / DLQ per config.
- Recoverable errors: decide explicitly to swallow or retry. Never silently swallow.

## Deployment and rollback

- All Lambda config lives in CloudFormation — no click-ops. See [cloudformation](cloudformation.md).
- Before shipping a runtime-affecting change, see [aws-testing](aws-testing.md).

## Debugging

When a Lambda is misbehaving, start with [lambda-failure-debugging](../runbooks/lambda-failure-debugging.md).

## Starter sources

> Expand as staging material compiles in.
