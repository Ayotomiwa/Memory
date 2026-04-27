# Type: CloudFormation Infrastructure

## Read before any implementation task

- atlas/standards/cloudformation.md
- atlas/standards/aws-testing.md

## Before changing any export value

An export change breaks every stack that imports it:

- atlas/dependency-map.md — identify all stacks consuming this export

Pattern: add new export alongside old (parallel), migrate consumers, remove old. Never rename or remove an export that has active importers.

## Escalation

- For prod rollback, escalate to Run the Bank with stack name, environment, failed resource, last stack event, and MR/deploy identifier.

## Relevant skills

- `/aws-test-plan` — post-deploy validation checklist; run before merging any stack change
- `/repo-impact` — list stacks affected before changing an export value

Full catalog: `claude-assets/skills-catalog.md`
