# Runbook — Lambda failure debugging

When a Lambda is erroring, timing out, or behaving weirdly.

Related: [[aws-lambda]], [[aws-testing]], [[observability]], [[sqs-backlog-debugging]]

## Symptoms this covers

- `Errors` metric above baseline
- `Duration` p99 approaching timeout
- DLQ growing
- Downstream consumers report missing or malformed events

## Step 1 — Identify the Lambda and its context

- Which repo? Check [[repo-catalog]] or the alarm description.
- What does it do? Read `atlas/repos/<repo>.md`, especially "AWS context" and "Known gotchas".
- What event or flow triggered it? Cross-reference the relevant flow page ([[raw-to-curated-flow]]).

## Step 2 — CloudWatch logs

- Pull logs for the exact time window of the alarm.
- Search for the "outcome" log (`"event": "outcome"`). If absent, the handler crashed before the outcome log — suspect import-time or early-initialization issues.
- Search for `correlationId` of a known failing invocation to trace across services.
- Look for patterns: does it fail on a specific record/key/partition?

## Step 3 — Lambda metrics

- `Errors` rate vs. `Invocations` rate. 100% errors → deployment or config; intermittent → data or downstream.
- `Duration p95/p99` vs. configured timeout. Close to timeout? See [[aws-lambda]] on timeout tuning.
- `Throttles` > 0 → reserved concurrency or regional quota; escalate.
- `IteratorAge` (for stream sources) → consumer falling behind.

## Step 4 — DLQ inspection

- Sample 3–5 messages from the DLQ. Are they the same shape? Same data pattern?
- If the DLQ is the origin of the problem (poison pill), isolate the bad message, store it in `staging/aws-findings/`, redrive the rest.

## Step 5 — Upstream

- Did an upstream repo change recently? Check [[dependency-map]] for the producer.
- Did an event schema change? Check [[data-events]] and [[event-contracts]].
- Did the infrastructure change? Check recent MRs on [[datalake-cfn]].

## Step 6 — Downstream

- If the Lambda ran successfully but downstream is broken, switch to that Lambda's runbook.
- Check if the Lambda writes to a queue with backing pressure — see [[sqs-backlog-debugging]].

## Step 7 — Decide

- **Rollback** — if the current version is newly deployed and the error started with that deploy. See [[cloudformation-rollback]].
- **Hotfix** — if the fix is small and the blast radius is known.
- **Scale** — if it is a concurrency or timeout issue that a config change can address.
- **Escalate** — if root cause is unclear after ~30 minutes.

## Step 8 — Capture

Before closing the incident, write a short note to `staging/incidents/` or `staging/debugging-notes/`:

- What symptom?
- What was the actual cause?
- What was the fix?
- What should future engineers know?

## Related repos

- [[ingestion-lambdas]]
- [[quality-checks-lambda]]
