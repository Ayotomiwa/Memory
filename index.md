# Engineering Context Index

[CLAUDE](CLAUDE.md) - operating rules | [log](log.md) - changelog

---

## Standards

- [java-services](atlas/standards/java-services.md)
- [python-services](atlas/standards/python-services.md)
- [aws-lambda](atlas/standards/aws-lambda.md)
- [cloudformation](atlas/standards/cloudformation.md)
- [aws-testing](atlas/standards/aws-testing.md)
- [event-contracts](atlas/standards/event-contracts.md)

## Repo map

- [repo-catalog](atlas/repo-catalog.md) - every repo, one-line summary
- [dependency-map](atlas/dependency-map.md) - who depends on whom (events, APIs, libraries, infra)

## Repos

One page per repo. See [_repo-template](atlas/repos/_repo-template.md) for the repo-page template.

**Services / Lambdas / Glue:**
- [dl-ingestion-lambdas](atlas/repos/dl-ingestion-lambdas.md) - Python Lambdas, raw ingestion
- [dl-quality-checks-lambda](atlas/repos/dl-quality-checks-lambda.md) - Python Lambda, quality gate
- [curated-etl-glue](atlas/repos/curated-etl-glue.md) - Glue PySpark jobs, raw -> curated
- [lineage-service](atlas/repos/lineage-service.md) - Java service, lineage graph
- [analytics-api](atlas/repos/analytics-api.md) - Java service, curated data API

**Libraries:**
- [data-lib-platform-pylib](atlas/repos/data-lib-platform-pylib.md) - shared Python utilities
- [data-lib-events](atlas/repos/data-lib-events.md) - shared event schemas (Python + Java)

**Infrastructure:**
- [datalake-cfn](atlas/repos/datalake-cfn.md) - CloudFormation for shared data lake

**Template:**
- [_repo-template](atlas/repos/_repo-template.md) — starter page for new repos

## Flows

- [raw-to-curated-flow](atlas/flows/raw-to-curated-flow.md) - the main data-platform flow
- [vendor-onboarding-flow](atlas/flows/vendor-onboarding-flow.md) - add a new upstream data source
- [quality-rejection-flow](atlas/flows/quality-rejection-flow.md) - handle rejected raw batches
- [event-schema-rollout-flow](atlas/flows/event-schema-rollout-flow.md) - change shared event schemas safely
- [dataset-query-flow](atlas/flows/dataset-query-flow.md) - serve curated data with provenance
- [flows-guide](atlas/flows/flows-guide.md) - how to write a flow page

## Runbooks

- [lambda-failure-debugging](atlas/runbooks/lambda-failure-debugging.md)
- [sqs-backlog-debugging](atlas/runbooks/sqs-backlog-debugging.md)

## Decisions (ADRs)

- [_adr-template](atlas/decisions/_adr-template.md) - template with filled-in example

## Onboarding

Lives at `onboarding/`.

- [new-developer-start-here](onboarding/new-developer-start-here.md)
- [using-claude-with-this-repo](onboarding/using-claude-with-this-repo.md)
- [maintaining-the-atlas](onboarding/maintaining-the-atlas.md) - weekly maintenance process for the lead

## Repo guides

Pre-task context loaders - what to read and which libraries to use before working in a repo of this type. Referenced by each local `CLAUDE.md` type pointer.

- [python-lambda](claude-assets/repo-guides/python-lambda.md) - `claude-assets/repo-guides/python-lambda.md`
- [java-service](claude-assets/repo-guides/java-service.md) - `claude-assets/repo-guides/java-service.md`
- [glue-job](claude-assets/repo-guides/glue-job.md) - `claude-assets/repo-guides/glue-job.md`
- [python-library](claude-assets/repo-guides/python-library.md) - `claude-assets/repo-guides/python-library.md`
- [java-library](claude-assets/repo-guides/java-library.md) - `claude-assets/repo-guides/java-library.md`
- [cloudformation-repo](claude-assets/repo-guides/cloudformation-repo.md) - `claude-assets/repo-guides/cloudformation-repo.md`
- [local-claude-md](claude-assets/repo-guides/local-claude-md.md) - `claude-assets/repo-guides/local-claude-md.md` - template for a local repo CLAUDE.md

## Claude assets

- [skills-catalog](claude-assets/skills-catalog.md)
- [prompts-catalog](claude-assets/prompts-catalog.md)
- [claude-assets-guide](claude-assets/claude-assets-guide.md) - how to add and maintain skills and prompts

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
