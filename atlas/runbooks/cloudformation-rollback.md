# Runbook — CloudFormation rollback

When a stack update goes bad and needs to be undone safely.

Related: [[cloudformation]], [[aws-testing]], [[datalake-cfn]]

## Symptoms this covers

- Stack in `UPDATE_ROLLBACK_IN_PROGRESS`, `UPDATE_ROLLBACK_FAILED`, or `UPDATE_FAILED`.
- Stack succeeded `UPDATE_COMPLETE` but the deployed change broke runtime.
- Exports changed, downstream stacks are unhappy.

## Decision tree

```
Is the stack in a failed/rollback state?
├─ Yes → follow "Stack-level rollback" below
└─ No → the deploy succeeded but behavior is wrong
        └─ Is the latest template version known-good?
            ├─ No → "Revert MR" below (redeploy previous template)
            └─ Yes → the data/runtime is the problem, not the stack; leave CFN alone and fix forward
```

## Stack-level rollback

### State: UPDATE_ROLLBACK_IN_PROGRESS

CloudFormation is already rolling back. **Do not force anything.** Watch `DescribeStackEvents`. Common outcomes:

- Rolls back cleanly → investigate what failed and fix the template.
- Fails to roll back (stuck resource) → see "Stuck rollback".

### State: UPDATE_ROLLBACK_FAILED

You need to continue the rollback after fixing the blocker.

1. Identify the resource that blocked rollback in `DescribeStackEvents`.
2. Fix the blocker out-of-band (most common: an IAM role or bucket policy that prevents a delete; or a resource that drifted from CloudFormation's record).
3. Run `ContinueUpdateRollback` — optionally skipping the blocked resource if you've handled it manually.
4. Confirm the stack reaches `UPDATE_ROLLBACK_COMPLETE`.

### Stuck rollback

If continue-update-rollback repeatedly fails, the last resorts are:

- Skip the offending resource with `--resources-to-skip`, then reconcile manually.
- As a **last** option: mark the stack in `REVIEW_IN_PROGRESS` via `ContinueUpdateRollback` with resource skip, import the resource back cleanly, and redeploy.
- Do **not** delete the stack if it owns shared resources — see [[datalake-cfn]] gotchas.

## Revert MR rollback (stack is `UPDATE_COMPLETE` but broken)

1. Identify the MR that introduced the bad change.
2. Revert it via a new MR — do not force-push the branch.
3. Deploy the revert MR to `dev`, then `stage`, then `prod`.
4. Validate per [[aws-testing]] after each environment.

## Data-preserving considerations

- If the bad change was a `Replacement` of a stateful resource (RDS, DynamoDB, S3), rollback may **not** restore data. Check the resource's replacement behavior before expecting rollback to save you.
- `DeletionPolicy: Retain` on stateful resources is the prevention pattern — ensure it is set on every stateful resource in [[datalake-cfn]].

## Cross-stack impact

If the rolled-back stack exports values consumed by others (typical for [[datalake-cfn]]):

1. Identify downstream stacks with `ListExports` + `ListImports`.
2. Communicate the rollback to the owning teams.
3. Confirm downstream stacks still function — run the [[raw-to-curated-flow]] happy path.

## Capture the learning

Write to `staging/incidents/` with:

- Which stack and MR.
- Why rollback was chosen over fix-forward.
- What worked, what didn't.
- Any CloudFormation behavior you discovered (add to `staging/aws-findings/` as well — those become standards updates).
