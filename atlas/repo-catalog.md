# Repo catalog

Every repo owned by the team, one row each. The authoritative list.

If a repo is not listed here, it is either new (add it) or deprecated (mark it).

Related: [dependency-map](dependency-map.md)

## Services

| Repo | Type | Owner | One-line purpose | Page |
|---|---|---|---|---|
| dl-ingestion-lambdas | Python Lambdas | Data Ingestion | Pulls raw data into the lake's raw zone | [dl-ingestion-lambdas](repos/dl-ingestion-lambdas.md) |
| dl-quality-checks-lambda | Python Lambda | Data Ingestion | Runs quality checks on raw batches | [dl-quality-checks-lambda](repos/dl-quality-checks-lambda.md) |
| curated-etl-glue | Glue PySpark jobs | Data Products | Transforms raw → curated | [curated-etl-glue](repos/curated-etl-glue.md) |
| lineage-service | Java service | Data Platform | Maintains data lineage graph | [lineage-service](repos/lineage-service.md) |
| analytics-api | Java service | Data Products | Serves curated data over HTTP | [analytics-api](repos/analytics-api.md) |

## Libraries

| Repo | Type | Owner | Consumers | Page |
|---|---|---|---|---|
| data-lib-platform-pylib | Python library | Data Platform | Every Python runtime in the team | [data-lib-platform-pylib](repos/data-lib-platform-pylib.md) |
| data-lib-events | Python + Java schema library | Data Platform | All event producers / consumers | [data-lib-events](repos/data-lib-events.md) |

## Infrastructure

| Repo | Type | Owner | Scope | Page |
|---|---|---|---|---|
| datalake-cfn | CloudFormation | Data Platform | Shared data lake infrastructure | [datalake-cfn](repos/datalake-cfn.md) |

## Deprecated / archived

| Repo | Archived on | Reason | Successor |
|---|---|---|---|
| (none yet) | | | |

## How to add a repo

1. Add a row in the appropriate table above.
2. Create `atlas/repos/<repo-name>.md` using the template in [_repo-template](repos/_repo-template.md).
3. Update [dependency-map](dependency-map.md) if the new repo produces or consumes cross-repo contracts.
4. Log the addition in `log.md`.
