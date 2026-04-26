# Type: CloudFormation Infrastructure

## Read before any implementation task

- atlas/standards/cloudformation.md
- atlas/standards/aws-testing.md

## Before changing any export value

An export change breaks every stack that imports it:

- atlas/repo-map/dependency-map.md — identify all stacks consuming this export
- atlas/runbooks/cloudformation-rollback.md — know the rollback path before deploying

Pattern: add new export alongside old (parallel), migrate consumers, remove old. Never rename or remove an export that has active importers.

## Runbooks

- atlas/runbooks/cloudformation-rollback.md

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any stack change
- `/repo-impact` — list stacks affected before changing an export value

Full catalog: `claude-assets/skills-catalog.md`

## Related

[[cloudformation]] | [[aws-testing]] | [[dependency-map]] | [[cloudformation-rollback]] | [[datalake-cfn]]
