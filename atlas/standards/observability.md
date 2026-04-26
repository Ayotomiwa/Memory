# Observability — standards

Logs, metrics, traces, and the correlation fields that tie them together.

Related: [[aws-lambda]], [[java-services]], [[python-services]]

## Correlation IDs

Every request / message / invocation has:

- `correlationId` — business-level, propagates end-to-end across services.
- `requestId` — platform-assigned (Lambda `aws_request_id`, HTTP request id).
- `messageId` — event or message identifier when applicable.

Emit all three on every log line for the invocation.

## Logs

- JSON only. No unstructured `println` / `print`.
- Use the shared observability library.
- Every invocation emits a single "outcome" log:
  ```
  { "event": "outcome", "status": "ok|error", "durationMs": 123, ... }
  ```
- Errors include the exception type and message; stack trace is optional but recommended for non-expected errors.
- Do not log secrets, PII, or full request/response bodies.

## Metrics

- Use shared observability helpers for standard metrics (duration, error count, throughput).
- Custom metrics belong under a consistent namespace (team owns the namespace; recorded in [[aws-resources]]).
- Every Lambda emits at minimum: `errors`, `duration`, `throttles` (CloudWatch gives these automatically).

## Traces

- If tracing is available in the environment (e.g., X-Ray), propagate the trace header through all outbound SDK and HTTP calls.
- Do not drop spans at boundaries.

## Alerting

- Alert on user-visible symptoms, not internal counters.
- Document every alert in the owning repo's `atlas/repos/<repo>.md` under "Alerts", with a link to the relevant runbook.

## Starter sources

> Expand as staging material compiles in.
