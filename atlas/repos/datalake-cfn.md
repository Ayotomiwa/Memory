# datalake-cfn

## Summary

CloudFormation templates that own the shared AWS infrastructure of the data platform: S3 buckets, KMS keys, IAM roles, the EventBridge bus for data events, Glue Data Catalog databases, and the scheduler/webhook routes that trigger [[ingestion-lambdas]].

This repo owns the **shared substrate**. Individual service repos own their own stacks that reference resources exported here.

## Type

- **Type**: Infrastructure (CloudFormation)
- **Language / tooling**: CloudFormation YAML / `cfn-lint` / GitLab CI deploy pipeline
- **Repo URL**: `gitlab.company.internal/data/datalake-cfn`

## Responsibilities

- Define and deploy shared S3 buckets: `raw-zone-<env>`, `curated-zone-<env>`, `ingestion-quarantine-<env>`, `glue-scripts-<env>`.
- Define and deploy the `data-events-bus` EventBridge bus and core rules.
- Define Glue Data Catalog databases per domain and environment.
- Own the shared IAM roles used by Lambdas and Glue jobs to access the lake.
- Own KMS keys for at-rest encryption.
- Export stack outputs (bucket names, bus ARN, role ARNs) so consumer stacks can `Fn::ImportValue` them.

## Connections

### Consumers (stacks that import from this one)
- [[ingestion-lambdas]] — imports bus, raw bucket, quarantine bucket, ingestion role
- [[quality-checks-lambda]] — imports bus, raw bucket, quality role
- [[curated-etl-glue]] — imports bus, raw + curated buckets, catalog database, Glue role
- [[lineage-service]] — imports bus and read role
- [[analytics-api]] — imports curated bucket, catalog database, read role

### Upstream (depends on)
- The org networking stack (VPC, subnets) — owned outside the team

## Events / APIs

This repo does not publish or consume events itself, but it owns the infrastructure events flow through:

- EventBridge bus: `data-events-bus-<env>`
- EventBridge rules matching the [[data-events]] event schemas

## AWS context

- **Stacks** (typical list):
  - `datalake-core-<env>` — buckets, KMS, catalog
  - `datalake-events-<env>` — EventBridge bus + rules
  - `datalake-iam-<env>` — shared IAM roles
- **Key exports**:
  - `DataEventsBusArn`
  - `RawZoneBucketName` / `CuratedZoneBucketName` / `QuarantineBucketName`
  - `IngestionLambdaRoleArn` / `QualityLambdaRoleArn` / `GlueJobRoleArn`
  - `GlueCatalogDatabase<Domain>Name`

Cross-reference: [[aws-resources]].

## Known gotchas

- Exports are immutable once consumed. Renaming an output without deprecating the old one breaks every consumer stack. Never do it in one MR.
- Changing a bucket name property in CloudFormation triggers `Replacement` — data loss. Always use `DeletionPolicy: Retain` on the bucket, then manually migrate if absolutely needed.
- Updating the KMS key policy can silently break Glue jobs that assume the current key grants. Validate in `dev` first.
- The EventBridge bus cannot be renamed; it has to be rebuilt and every rule/subscription re-wired. Do not rename casually.

## Related docs

- Standards: [[cloudformation]], [[aws-testing]]
- Runbooks: [[cloudformation-rollback]]
- Map: [[aws-resources]]

## Claude routing

1. This page
2. [[cloudformation]]
3. [[aws-testing]]
4. [[cloudformation-rollback]]

If changing an export consumed by other stacks, also read:
- [[dependency-map]]
- Every consumer page listed above
- Rollout plan: stage the change across `dev` → `stage` → `prod`, and introduce new exports alongside old ones for one release cycle

## Validation expectations

- Local: `cfn-lint` on every changed template; `aws cloudformation validate-template` in CI.
- Pre-merge:
  - Deploy to `dev`.
  - Run a small smoke of each consumer (one ingest, one quality check, one Glue job, one analytics query).
  - Confirm no stack is in drift.
- Post-merge: see [[cloudformation]] and [[aws-testing]].
- Rollback: see [[cloudformation-rollback]].
