# Engineering Context Index

[[CLAUDE]] - operating rules | [[log]] - changelog

---

## Standards

- [[java-services]]
- [[python-services]]
- [[aws-lambda]]
- [[cloudformation]]
- [[aws-testing]]
- [[event-contracts]]
- [[observability]]

## Repo map

- [[repo-catalog]] - every repo, one-line summary
- [[dependency-map]] - who depends on whom (events, APIs, libraries, infra)
- [[ownership]] - which team owns what
- [[shared-libraries]] - libraries, consumers, and public contracts
- [[aws-resources]] - AWS resources by repo
- [[usage-summaries]] - consumer dependency usage collected from local CLAUDE.md files

## Repos

One page per repo. See [[_page-template]] for the repo-page guide and [[_example-service]] for the working template.

**Services / Lambdas / Glue:**
- [[ingestion-lambdas]] - Python Lambdas, raw ingestion
- [[quality-checks-lambda]] - Python Lambda, quality gate
- [[curated-etl-glue]] - Glue PySpark jobs, raw -> curated
- [[lineage-service]] - Java service, lineage graph
- [[analytics-api]] - Java service, curated data API

**Libraries:**
- [[data-platform-pylib]] - shared Python utilities
- [[data-events]] - shared event schemas (Python + Java)

**Infrastructure:**
- [[datalake-cfn]] - CloudFormation for shared data lake

**Template:**
- [[_example-service]] — starter page for new repos

## Flows

- [[raw-to-curated-flow]] - the main data-platform flow
- [[flows-guide]] - how to write a flow page

## Runbooks

- [[lambda-failure-debugging]]
- [[cloudformation-rollback]]
- [[sqs-backlog-debugging]]

## Decisions (ADRs)

- [[_adr-template]] - template with filled-in example

## Onboarding

Lives at `onboarding/` (root level).

- [[new-developer-start-here]]
- [[using-claude-with-this-repo]]
- [[maintaining-the-atlas]] - weekly maintenance process for the lead

## Repo guides

Pre-task context loaders - what to read and which libraries to use before working in a repo of this type. Referenced by each local `CLAUDE.md` type pointer.

- [[python-lambda]] - `atlas/repo-guides/python-lambda.md`
- [[java-service]] - `atlas/repo-guides/java-service.md`
- [[glue-job]] - `atlas/repo-guides/glue-job.md`
- [[python-library]] - `atlas/repo-guides/python-library.md`
- [[java-library]] - `atlas/repo-guides/java-library.md`
- [[cloudformation-repo]] - `atlas/repo-guides/cloudformation-repo.md`
- [[local-claude-md]] - `atlas/repo-guides/local-claude-md.md` - template for a local repo CLAUDE.md

## Concepts

- [[idempotency]]

## Claude assets

- [[skills-catalog]]
- [[prompts-catalog]]
- [[claude-assets-guide]] - how to add and maintain skills and prompts

---

## Raw source material

Lives under `staging/`. This is the single intake point for atlas knowledge, skill proposals, and prompt proposals. See each folder's README for conventions.

- `staging/new-repos/` - new repo onboarding entries
- `staging/deprecations/` - repo retirement entries
- `staging/skills/` - proposed new skills, reviewed during weekly lint
- `staging/prompts/` - proposed reusable prompts, reviewed during weekly lint
- `staging/confluence/` - Confluence exports
- `staging/repo-findings/` - discoveries made while working in a repo
- `staging/incidents/` - incident notes and postmortems
- `staging/meeting-notes/` - design and architecture meetings
- `staging/decisions/` - rough decision notes before they become ADRs
- `staging/mr-summaries/` - atlas-relevant MR notes only
- `staging/architecture-notes/` - rough architecture drafts
- `staging/aws-findings/` - AWS/runtime/deployment discoveries
- `staging/chat-discussions/` - important Slack/Teams threads
- `staging/debugging-notes/` - debugging sessions worth preserving
