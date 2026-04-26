# staging/aws-findings/

AWS, CloudFormation, Lambda, and deployment discoveries.

AWS knowledge is unusually easy to lose because it lives in consoles, logs, and people's heads. Capture it aggressively here.

## When to add a file here

- Lambda behavior that surprised you (cold starts, concurrency, timeouts, retries)
- CloudFormation gotcha (update behavior, replacement rules, stack drift)
- IAM quirk or permission pattern you had to discover
- CloudWatch log or metric pattern worth remembering
- SQS, SNS, EventBridge, Kinesis routing behavior
- Deployment verification step that should be standard
- Rollback scenario: what worked, what didn't

## Minimum content

```
---
date: YYYY-MM-DD
service: <Lambda | CloudFormation | SQS | EventBridge | IAM | CloudWatch | etc.>
repos: [list]
stack: <CloudFormation stack name, if relevant>
---

# <title>

## What I observed
The concrete behavior or output.

## Why it matters
The operational consequence.

## How to reproduce or verify
Commands, CLI calls, console steps.

## Workaround or fix
If any.
```

## Compile target

- `atlas/standards/aws-lambda.md`
- `atlas/standards/cloudformation.md`
- `atlas/standards/aws-testing.md`
- `atlas/runbooks/*.md`
- `atlas/repos/<repo>.md` — under "AWS context" or "Known gotchas"
- `atlas/repo-map/aws-resources.md`
