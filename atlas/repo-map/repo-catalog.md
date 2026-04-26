# Repo catalog

Every repo owned by the team, one row each. The authoritative list.

If a repo is not listed here, it is either new (add it) or deprecated (mark it).

Related: [[dependency-map]], [[ownership]], [[shared-libraries]]

## Services

| Repo | Type | Owner | One-line purpose | Page |
|---|---|---|---|---|
| ingestion-lambdas | Python Lambdas | Data Ingestion | Pulls raw data into the lake's raw zone | [[ingestion-lambdas]] |
| quality-checks-lambda | Python Lambda | Data Ingestion | Runs quality checks on raw batches | [[quality-checks-lambda]] |
| curated-etl-glue | Glue PySpark jobs | Data Products | Transforms raw → curated | [[curated-etl-glue]] |
| lineage-service | Java service | Data Platform | Maintains data lineage graph | [[lineage-service]] |
| analytics-api | Java service | Data Products | Serves curated data over HTTP | [[analytics-api]] |

## Libraries

| Repo | Type | Owner | Consumers | Page |
|---|---|---|---|---|
| data-platform-pylib | Python library | Data Platform | Every Python runtime in the team | [[data-platform-pylib]] |
| data-events | Python + Java schema library | Data Platform | All event producers / consumers | [[data-events]] |

## Infrastructure

| Repo | Type | Owner | Scope | Page |
|---|---|---|---|---|
| datalake-cfn | CloudFormation | Data Platform | Shared data lake infrastructure | [[datalake-cfn]] |

## Templates / starters

| Repo | Purpose | Page |
|---|---|---|
| _(none — these live outside the catalog)_ | Template page for copying | [[_example-service]] |

## Deprecated / archived

| Repo | Archived on | Reason | Successor |
|---|---|---|---|
| (none yet) | | | |

## How to add a repo

1. Add a row in the appropriate table above.
2. Create `atlas/repos/<repo-name>.md` using the working template in [[_example-service]] and the checklist in [[_page-template]].
3. Update [[dependency-map]] if the new repo produces or consumes cross-repo contracts.
4. Update [[ownership]] and [[aws-resources]].
5. Log the addition in `log.md`.
