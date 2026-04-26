# AWS resources by repo

A cross-repo index of the AWS resources each service/Lambda/Glue job owns.

Related: [[repo-catalog]], [[cloudformation]], [[aws-testing]]

## Why this page exists

- When an alarm fires, engineers need to find the repo owning the failing resource fast.
- When running AWS test plans, Claude needs to know which logs, queues, and stacks to look at.
- When doing cost/usage reviews, this is the starting index.

## Shared infrastructure (owned by [[datalake-cfn]])

| Resource | Name pattern | Notes |
|---|---|---|
| EventBridge bus | `data-events-bus-<env>` | All `data.*` events |
| S3 bucket — raw zone | `raw-zone-<env>` | Write by [[ingestion-lambdas]], read by [[quality-checks-lambda]] / [[curated-etl-glue]] |
| S3 bucket — curated zone | `curated-zone-<env>` | Write by [[curated-etl-glue]], read by [[analytics-api]] |
| S3 bucket — quarantine | `ingestion-quarantine-<env>` | Bad batches from [[quality-checks-lambda]] |
| S3 bucket — Glue scripts | `glue-scripts-<env>` | Deployed by [[curated-etl-glue]] pipeline |
| Glue Data Catalog | `curated_<domain>_<env>` | Schema owner for [[curated-etl-glue]] outputs |
| KMS keys | `datalake-<purpose>-<env>` | At-rest encryption |

## Per-repo resources

| Repo | Compute | Queues | Stacks | Log groups |
|---|---|---|---|---|
| [[ingestion-lambdas]] | Lambdas: `ingest-<source>-<dataset>` | `ingestion-dlq` | `ingestion-lambdas-<env>` | `/aws/lambda/ingest-*` |
| [[quality-checks-lambda]] | Lambda: `quality-checks-handler` | `quality-checks-events`, `quality-checks-dlq` | `quality-checks-lambda-<env>` | `/aws/lambda/quality-checks-handler` |
| [[curated-etl-glue]] | Glue jobs: `curated-<domain>-<dataset>` | — | `curated-etl-glue-<env>` | `/aws-glue/jobs/output`, `/aws-glue/jobs/error` |
| [[lineage-service]] | ECS Fargate service | `lineage-events`, `lineage-dlq` | `lineage-service-<env>` | `/ecs/lineage-service` |
| [[analytics-api]] | ECS Fargate service | — | `analytics-api-<env>` | `/ecs/analytics-api` |

## Alarms

Alarms live in the repo that owns the underlying resource. This page links to them indirectly via the repo page. Update the repo page's "AWS context" / "Alarms" section when adding or changing an alarm.

## Discovery

When you find an AWS resource not listed here:

1. Add a row in the right table.
2. Update the owning repo's `atlas/repos/<repo>.md`.
3. If orphaned (no owning repo), add to [[ownership]] "Orphaned" until resolved.
