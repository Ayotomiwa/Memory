# AWS testing — standards

How we validate AWS/runtime changes before and after deployment.

Related: [[aws-lambda]], [[cloudformation]], [[observability]], [[lambda-failure-debugging]]

## Principle

Local tests prove your code is correct. **AWS testing proves your deployed system is correct.** Both are required for changes that touch runtime behavior.

## Pre-merge (local + dev)

1. Unit tests pass.
2. Integration tests pass (LocalStack, Docker DB, etc. where applicable).
3. Deploy to `dev` or equivalent shared environment.
4. Execute the change's trigger path at least once in `dev`.
5. Confirm CloudWatch logs show the expected outcome log.
6. Confirm no unexpected errors or retries.

## Post-deploy (prod or production-like)

Every runtime-affecting deploy should be followed by:

1. **Lambda metrics** — check `Errors`, `Throttles`, `Duration p95/p99` for ~15 min.
2. **Queue depth** — `ApproximateNumberOfMessagesVisible` should return to baseline. Not increasing is the pass criterion.
3. **DLQ** — should not grow.
4. **Downstream consumers** — logs should show them processing events normally.
5. **Business metric** — whatever metric represents user-visible correctness.

## Rollback signals

Abort and roll back if any of:

- Lambda error rate rises above baseline.
- DLQ messages appear where none existed.
- Downstream consumer logs show parse failures.
- Stack enters `UPDATE_ROLLBACK_IN_PROGRESS`.
- Business metric degrades.

See [[cloudformation-rollback]] for the rollback playbook.

## Event contract changes

If the change affects an event schema, **every downstream consumer** listed in [[dependency-map]] must be validated in `dev` before merging to `prod`. See [[event-contracts]].

## Test plans

For substantial changes, Claude can generate a concrete AWS test plan by reading the repo's `atlas/repos/<repo>.md` and this page. Ask:

> Produce an AWS test plan for this change based on our aws-testing standard.

## Starter sources

> Expand as staging material compiles in.
