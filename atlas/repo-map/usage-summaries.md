# Usage summaries

Derived from consumer repos' local `CLAUDE.md` - `Dependencies and usage` sections. Source of truth is each consumer's local `CLAUDE.md`; this file is a collected view for impact analysis without needing `--add-dir` access to every consumer repo.

Update during the weekly pass or when a consumer's dependency section changes. See [[maintaining-the-atlas]].

Related: [[shared-libraries]], [[dependency-map]]

---

> [!warning] Coverage
> Blank cells and `_not yet collected_` rows mean the consumer's dependency usage has not been collected yet. They do not mean the consumer is unaffected.
> Until this file and the source local `CLAUDE.md` files are current, `/repo-impact` can confirm only a subset of consumers and must leave the rest in "Possibly affected."

---

## How to update

For each consumer in [[dependency-map]], read its local `CLAUDE.md` and copy its `Dependencies and usage` section here, grouped by shared library.

---

## data-platform-pylib

_Consumers: [[ingestion-lambdas]], [[quality-checks-lambda]], [[curated-etl-glue]]_

| Consumer | Uses | Does not use |
|---|---|---|
| ingestion-lambdas | _not yet collected_ | |
| quality-checks-lambda | _not yet collected_ | |
| curated-etl-glue | _not yet collected_ | |

---

## data-events

_Consumers: all event producers and consumers - see [[dependency-map]]._

| Consumer | Event | Fields read | Fields not used |
|---|---|---|---|
| ingestion-lambdas | _not yet collected_ | | |
| quality-checks-lambda | _not yet collected_ | | |
| curated-etl-glue | _not yet collected_ | | |
| lineage-service | _not yet collected_ | | |

---

## Shared Java observability library

_Consumers: [[lineage-service]], [[analytics-api]]_

| Consumer | Uses | Does not use |
|---|---|---|
| lineage-service | _not yet collected_ | |
| analytics-api | _not yet collected_ | |
