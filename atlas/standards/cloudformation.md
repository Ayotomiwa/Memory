# CloudFormation — standards

Conventions for CloudFormation templates and stacks.

Related: [aws-lambda](aws-lambda.md), [aws-testing](aws-testing.md)

## Template layout

- One stack per deployable unit. Avoid mega-stacks with unrelated resources.
- Parameters at top; resources grouped by logical role (networking, compute, data, IAM, monitoring).
- Tag every resource with at least: `Service`, `Owner`, `Environment`, `Repo`.

## Naming

- Stack name: `<service>-<environment>` (e.g., `payments-service-prod`).
- Logical resource IDs use PascalCase and describe the role, not the type (`PaymentStatusQueue`, not `SQSQueue1`).

## Change risk

Some changes replace resources rather than update them, which can be destructive. Review the CloudFormation "Update requires" column in AWS docs before merging:

- `Replacement`: resource is deleted and recreated. Data loss is possible.
- `Some interruptions`: brief downtime.
- `No interruption`: safe.

High-risk resource types to double-check: RDS, DynamoDB table keys, Lambda function names, log group names, IAM role ARNs.

## Env vars on Lambda

Updating a Lambda's env vars triggers a function update. For zero-downtime flows, make sure the new env value is compatible with both the old and new code versions during the rolling update. See `staging/aws-findings/` for team-specific cases as they accrue.

## Failed deploys and rollback

- Prod rollback is owned by the Run the Bank team. If a prod stack update fails or needs rollback, stop changing the stack and escalate with the stack name, environment, failed resource, last stack event, and MR/deploy identifier.
- For `dev` and other team-owned environments, prefer fix-forward or revert through the normal MR/deploy path unless the owning team explicitly approves a rollback.
- Watch stack events during deploy; do not merge the MR until the stack reaches `UPDATE_COMPLETE` (or `CREATE_COMPLETE`) in all target environments.

## Drift

- Stack drift means something was changed outside CloudFormation. This is a bug — fix by putting the change back into the template, not by ignoring it.
- Periodically run drift detection on production stacks.

## Testing

See [aws-testing](aws-testing.md) for runtime validation steps after a stack update.

## Starter sources

> Expand as staging material compiles in.
