# Runbook — SQS backlog debugging

When an SQS queue's depth keeps growing.

Related: [aws-lambda](../standards/aws-lambda.md), logging/metrics expectations, [lambda-failure-debugging](lambda-failure-debugging.md)

## Symptoms this covers

- `ApproximateNumberOfMessagesVisible` trending up over many minutes.
- `ApproximateAgeOfOldestMessage` climbing.
- `IteratorAge` (for Lambda SQS triggers) high.
- Downstream signals (lineage lag, analytics freshness) behind expected.

## Step 1 — Which queue, which consumer

- Identify the queue from the alarm.
- Cross-reference `AWS context` to find the owning repo.
- Navigate to the owning repo's atlas page (linked from [repo-catalog](../repo-catalog.md)) to find the consumer Lambda or service.

## Step 2 — Is the consumer alive?

- Check the consumer's invocation rate. Zero? The SQS trigger / event source mapping is broken or disabled.
- Check the consumer's error rate. High? See [lambda-failure-debugging](lambda-failure-debugging.md) — backlog is a symptom, not the cause.
- Check throttles. Throttling + backlog = concurrency issue.

## Step 3 — Is the consumer slower than the producer?

- Compare producer rate (upstream events) to consumer rate (invocations).
- Producer > consumer sustained → either scale consumer or the work per message has grown.

## Step 4 — Per-message investigation

- Peek at the oldest visible message. Is it malformed? A poison pill?
- Check the DLQ. If messages are going there, poison pill is likely — quarantine and redrive.

## Step 5 — Common causes

- **New field in the event** — consumer crashes on deserialization. Check [event-contracts](../standards/event-contracts.md) and [data-lib-events](../repos/data-lib-events.md).
- **Downstream dependency slow** — consumer is waiting on DB / HTTP / downstream service.
- **Concurrency cap** — reserved concurrency limit on the Lambda; Lambda throttles visible in metrics.
- **Batch size wrong** — batch size too small wastes invocations; too large causes timeouts.
- **Visibility timeout too low** — messages redelivered before processing completes, multiplying the apparent queue depth.

## Step 6 — Actions

- Temporary relief: bump reserved concurrency (only if the downstream can handle it).
- If poison pill: isolate the message, store it in `staging/aws-findings/`, redrive the rest.
- If schema drift: coordinate with the producer team; see [event-contracts](../standards/event-contracts.md).
- If deep downstream slowness: queue is a symptom; fix the slow dependency.

## Step 7 — Capture

On the way out, add to `staging/debugging-notes/` — especially if the cause was a non-obvious Lambda + SQS interaction. Common SQS+Lambda gotchas should end up in [aws-lambda](../standards/aws-lambda.md).

## Related queues (this team)

- `dl-ingestion-dlq` — owned by [dl-ingestion-lambdas](../repos/dl-ingestion-lambdas.md)
- `dl-quality-checks-events`, `dl-quality-checks-dlq` — owned by [dl-quality-checks-lambda](../repos/dl-quality-checks-lambda.md)
- `lineage-events`, `lineage-dlq` — owned by [lineage-service](../repos/lineage-service.md)
