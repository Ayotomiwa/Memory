# Ownership

Who owns what.

Related: [[repo-catalog]]

## Teams

| Team | Scope | Primary contact | Backup |
|---|---|---|---|
| Data Platform | Shared infra, libraries, lineage | <name> | <name> |
| Data Ingestion | Raw ingestion, quality gates | <name> | <name> |
| Data Products | Curated pipelines, analytics API | <name> | <name> |

## Repo ownership

| Repo | Owning team | Backup | Notes |
|---|---|---|---|
| [[ingestion-lambdas]] | Data Ingestion | Data Platform | High change rate — new sources onboard here |
| [[quality-checks-lambda]] | Data Ingestion | Data Platform | Critical path — rejections block curated pipelines |
| [[curated-etl-glue]] | Data Products | Data Platform | Domain split inside: finance, customer, product |
| [[lineage-service]] | Data Platform | — | Read-only consumer of every event |
| [[analytics-api]] | Data Products | Data Platform | Customer-facing SLAs |
| [[data-platform-pylib]] | Data Platform | — | Cross-team library |
| [[data-events]] | Data Platform | — | Cross-team contract |
| [[datalake-cfn]] | Data Platform | — | Shared substrate |

## Shared resources

| Resource | Owner | Notes |
|---|---|---|
| `data-events-bus` EventBridge | Data Platform ([[datalake-cfn]]) | Shared event bus |
| Raw / curated / quarantine S3 buckets | Data Platform ([[datalake-cfn]]) | Shared buckets |
| Glue Data Catalog databases | Data Platform ([[datalake-cfn]]) | Schema authority |
| KMS keys (at-rest encryption) | Data Platform ([[datalake-cfn]]) | Key policy changes are high-risk |

## Orphaned

Repos with no owner are a bug. List them here until resolved.

| Repo | Added here on | Suggested owner |
|---|---|---|
| (none) | | |
