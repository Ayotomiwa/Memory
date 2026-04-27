# Engineering Context Log

Chronological record of ingests, lints, and structural changes to the atlas.
Newest entries go at the top.

Entry format:

```
## [YYYY-MM-DD] <type> | <one-line summary>
- Bullet list of pages touched or findings.
```

Types:
- `ingest` — a staging source was compiled into atlas pages
- `lint` — weekly maintenance pass
- `structure` — folders/files reorganized
- `decision` — new ADR added
- `contradiction` — a conflict was flagged between sources

---

## [2026-04-27] structure | Move onboarding docs from atlas/ to root onboarding/

- `atlas/onboarding/maintaining-the-atlas.md`, `atlas/onboarding/new-developer-start-here.md`, `atlas/onboarding/using-claude-with-this-repo.md` - moved to `onboarding/`
- `index.md`, `claude-assets/repo-guides/local-claude-md.md` - updated onboarding links to the root path

## [2026-04-27] lint | Weekly pass: scaffolding only; orphan archive guide persists

- Files ingested: 0
- Files deferred: 19 (all staging scaffolding READMEs/templates across `staging/`, `aws-findings/`, `architecture-notes/`, `chat-discussions/`, `confluence/`, `debugging-notes/`, `decisions/`, `deprecations/`, `incidents/`, `meeting-notes/`, `mr-summaries/`, `new-repos/`, `prompts/`, `repo-findings/`, and `skills/`)
- Files discarded: 0
- Atlas issues: orphan `atlas/repos/_archived/_archive-guide.md` persists; no broken wikilinks found; no obvious outdated curated pages found
- Claude assets issues: all skills-catalog and prompts-catalog source targets exist
- Skill proposals reviewed: none (only `staging/skills/README.md` and `staging/skills/_template.md`)
- Prompt proposals reviewed: none (only `staging/prompts/README.md` and `staging/prompts/_template.md`)

## [2026-04-27] lint | Routine routing cleanup after structure changes

- `CLAUDE.md` - aligned operating rules with current Markdown links, `atlas/dependency-map.md`, `claude-assets/repo-guides/`, `atlas/onboarding/`, and removed concept-layer routing
- `claude-assets/skills-catalog.md`, `staging/new-repos/README.md`, `staging/new-repos/_template.md`, `staging/deprecations/_template.md` - removed stale repo-map/shared-libraries/aws-resources/ownership routing
- `atlas/standards/event-contracts.md`, `atlas/standards/python-services.md` - pointed shared-library references at `dependency-map`

## [2026-04-27] structure | Tune Obsidian graph for repo relationships

- `.obsidian/graph.json` - default graph now focuses on active repo pages, hides unresolved/template/archive noise, shows arrows, and colors services, shared libraries, infrastructure, flows, runbooks, and standards

## [2026-04-27] structure | Make demo repo graph more realistic

- Renamed Lambda repo pages to `dl-ingestion-lambdas` and `dl-quality-checks-lambda`
- Renamed shared library repo pages to `data-lib-platform-pylib` and `data-lib-events`
- Added [vendor-onboarding-flow](atlas/flows/vendor-onboarding-flow.md), [quality-rejection-flow](atlas/flows/quality-rejection-flow.md), [event-schema-rollout-flow](atlas/flows/event-schema-rollout-flow.md), and [dataset-query-flow](atlas/flows/dataset-query-flow.md)
- Updated [dependency-map](atlas/dependency-map.md), [repo-catalog](atlas/repo-catalog.md), repo pages, runbooks, and Obsidian graph settings for the new names and richer flow relationships

## [2026-04-27] structure | Merge repo templates

- `atlas/repos/_repo-template.md` - merged the former `_example-service` and `_page-template` pages into one repo template with placeholder-only repo references
- `index.md`, `atlas/repo-catalog.md`, `atlas/onboarding/maintaining-the-atlas.md`, `staging/new-repos/README.md`, `staging/new-repos/_template.md` - updated repo-template references

## [2026-04-27] structure | Remove concept layer

- Removed `atlas/concepts/`; the only page was idempotency guidance, which fits better in runtime standards than as a separate top-level layer
- Moved durable Lambda retry/idempotency rules into `atlas/standards/aws-lambda.md`
- Updated repo guides, repo pages, staging guidance, and `index.md` to stop routing through `concepts/`

## [2026-04-27] structure | Remove non-owned rollback and observability pages

- Removed `atlas/runbooks/cloudformation-rollback.md`; prod rollback is owned by Run the Bank, so atlas guidance now routes prod rollback escalation there
- Removed `atlas/standards/observability.md`; concrete logging/metrics expectations stay inline in language and Lambda standards
- Updated index, flow docs, repo pages, repo guides, and AWS testing/cloudformation standards to remove stale links

## [2026-04-26] lint | All staging scaffolding; orphan archive guide persists (3rd consecutive lint)

- Files ingested: 0
- Files deferred: 19 (all scaffolding READMEs/templates; includes 7 subfolders not enumerated in prior lints — `repo-findings/`, `incidents/`, `meeting-notes/`, `decisions/`, `architecture-notes/`, `aws-findings/`, `debugging-notes/` — all contain only README.md)
- Files discarded: 0
- Atlas issues: orphan `atlas/repos/_archived/_archive-guide.md` persists — no inbound wikilinks from `index.md` or any atlas page; flagged for team decision (add index link vs. leave undiscoverable)
- Broken wikilinks: none
- Outdated pages: none found
- Skills-catalog targets: all 5 skill source files exist
- Prompts-catalog targets: all 3 prompt source files exist
- Skill proposals reviewed: none (only README.md and _template.md in staging/skills/)
- Prompt proposals reviewed: none (only README.md and _template.md in staging/prompts/)

## [2026-04-26] structure | Contradictions and terminology alignment pass

- `atlas/onboarding/maintaining-the-atlas.md`, `.claude/skills/weekly-lint/SKILL.md` - aligned `discard` semantics with staging audit-trail policy (do not delete staging files)
- `atlas/dependency-map.md`, `atlas/dependency-map.md`, `local CLAUDE.md Dependencies and usage sections`, `atlas/repos/data-lib-platform-pylib.md` - removed incorrect `lineage-service` dependency on `data-lib-platform-pylib`
- `atlas/standards/event-contracts.md`, `claude-assets/prompts/impact-analysis-for-event-change.md` - aligned event guidance to inline event documentation model and removed `atlas/events/` reference
- `staging/new-repos/_template.md` - aligned repo-type token to `cloudformation-repo`
- `log.md` - corrected stale `atlas/repos/example-service.md` reference to `atlas/repos/_example-service.md`

## [2026-04-26] lint | No ingest candidates; orphan archive guide still present

- Files ingested: 0
- Files deferred: 8 (`staging/README.md`, `staging/chat-discussions/README.md`, `staging/confluence/README.md`, `staging/deprecations/README.md`, `staging/deprecations/_template.md`, `staging/mr-summaries/README.md`, `staging/new-repos/README.md`, `staging/new-repos/_template.md` — all scaffolding or templates, no durable content changes required)
- Files discarded: 0
- Staging files reviewed since last lint: `staging/README.md`, `staging/chat-discussions/README.md`, `staging/confluence/README.md`, `staging/deprecations/README.md`, `staging/deprecations/_template.md`, `staging/mr-summaries/README.md`, `staging/new-repos/README.md`, `staging/new-repos/_template.md`, plus proposal scaffolds in `staging/skills/` and `staging/prompts/`
- Atlas issues found: orphan page `atlas/repos/_archived/_archive-guide.md` (still has no inbound wikilinks from `index.md` or `atlas/`); no non-template broken wikilinks in `atlas/`; no obvious outdated curated pages found in this pass
- Claude assets issues found: all `skills-catalog` and `prompts-catalog` source targets exist
- Skill proposals reviewed: none (only `staging/skills/README.md` and `staging/skills/_template.md`)
- Prompt proposals reviewed: none (only `staging/prompts/README.md` and `staging/prompts/_template.md`)

## [2026-04-26] lint | Full scan: curated links clean; 1 orphan page; 1 stale log path

- Files ingested: 0
- Files deferred: 8 (all were staging README/template scaffolding; no durable content updates)
- Files discarded: 0
- Staging files reviewed since last lint: `staging/README.md`, `staging/chat-discussions/README.md`, `staging/confluence/README.md`, `staging/deprecations/README.md`, `staging/deprecations/_template.md`, `staging/mr-summaries/README.md`, `staging/new-repos/README.md`, `staging/new-repos/_template.md`, plus proposal scaffolds in `staging/skills/` and `staging/prompts/`
- Atlas issues found: orphan page `atlas/repos/_archived/_archive-guide.md` (no inbound wikilinks from `index.md` or `atlas/`); no broken wikilinks in `atlas/`; no missing repo pages vs `atlas/repo-catalog.md`
- Claude assets issues found: all `skills-catalog` and `prompts-catalog` source targets exist
- Skill proposals reviewed: none (only `staging/skills/README.md` and `staging/skills/_template.md`)
- Prompt proposals reviewed: none (only `staging/prompts/README.md` and `staging/prompts/_template.md`)
- Additional inconsistency outside curated scan scope: this log's latest structure entry references `atlas/repos/example-service.md`; current file is `atlas/repos/_example-service.md`

## [2026-04-26] structure | Direct wording pass

- `atlas/onboarding/using-claude-with-this-repo.md`, `.claude/skills/weekly-lint/SKILL.md`, `claude-assets/skills-catalog.md`, `atlas/onboarding/maintaining-the-atlas.md`, `staging/chat-discussions/README.md`, `staging/confluence/README.md` - tightened current-state wording in live guidance
- `atlas/repos/_example-service.md` - removed redundant template pointer; use `atlas/repos/_example-service.md`

## [2026-04-26] structure | Local bootstrap and curated intake tightened

- `claude-assets/repo-guides/local-claude-md.md` - added required startup routing for generated local `CLAUDE.md` files and central-context availability handling
- `atlas/onboarding/using-claude-with-this-repo.md` - documented durable-layer curation from staging
- `.claude/skills/ingest-staging/SKILL.md` - documented staging-to-durable-layer curation
- `claude-assets/prompts/` - added missing source files referenced by `prompts-catalog.md`

## [2026-04-26] structure | Staging set as single intake for all curated layers

- `CLAUDE.md`, `staging/README.md`, `atlas/onboarding/maintaining-the-atlas.md` - documented that `staging/` feeds `atlas/`, `.claude/skills/`, and `claude-assets/`
- `staging/prompts/` - added proposal queue and template for reusable prompts
- `claude-assets/claude-assets-guide.md`, `claude-assets/skills-catalog.md`, `index.md` - documented prompt and skill maintenance flow
- `.claude/skills/weekly-lint/SKILL.md` - added prompt proposal review and asset catalog target checks

## [2026-04-26] structure | Workflow docs aligned; event granularity removed; skill drift fixed

- `CLAUDE.md`, `index.md`, `atlas/onboarding/using-claude-with-this-repo.md`, `atlas/onboarding/maintaining-the-atlas.md` — aligned on staging-first compilation, removed standalone event-note routing, clarified archived repo path handling
- `atlas/dependency-map.md`, `atlas/flows/raw-to-curated-flow.md`, `atlas/repos/data-lib-events.md`, `atlas/repos/dl-ingestion-lambdas.md`, `atlas/repos/dl-quality-checks-lambda.md`, `atlas/repos/curated-etl-glue.md`, `atlas/repos/lineage-service.md` — kept event names inline as supporting detail rather than first-class atlas pages
- `atlas/repo-catalog.md`, `local CLAUDE.md Dependencies and usage sections`, `atlas/repos/_page-template.md` — aligned repo-page and impact-analysis guidance with the repo/flow-level event model
- `.claude/skills/new-repo-compile/SKILL.md`, `.claude/skills/repo-impact/SKILL.md`, `.claude/skills/weekly-lint/SKILL.md`, `claude-assets/skills-catalog.md` — fixed rename drift and matched the documented process
- `staging/new-repos/README.md`, `staging/new-repos/_template.md`, `staging/deprecations/README.md` — updated compilation and archival checklists
- `atlas/repos/_archived/_archive-guide.md` — documented how archived repo pages are stored

## [2026-04-26] structure | atlas/repo-types/ → claude-assets/repo-guides/; repos-guide.md → _page-template.md

- `atlas/repo-types/` renamed to `claude-assets/repo-guides/` — "repo guides" clarifies purpose (pre-task context loaders) vs. "repo types" which implied classification
- `atlas/repos/repos-guide.md` renamed to `atlas/repos/_page-template.md` — more specific name; `_` prefix sorts it first; avoids collision with `repo-guides/`
- `index.md` — section "Repo types" → "Repo guides"; added one-line description; updated 7 path references; ``repos-guide`` → `atlas/repos/_page-template.md`
- `CLAUDE.md` — wikilink table: "Repo type" → "Repo guide", path updated
- `claude-assets/repo-guides/local-claude-md.md` — 7 internal path references updated
- `atlas/repo-catalog.md` — ``repos-guide`` → `atlas/repos/_page-template.md`
- `atlas/onboarding/using-claude-with-this-repo.md` — path reference updated

## [2026-04-26] lint | First weekly pass — no staging content; 6 wikilink fixes; 13 orphan stubs deleted

**Staging:** All 15 non-skills staging files are READMEs/templates — no ingest actions. No skill proposals in `staging/skills/`.

**Wikilink fixes (5 files):**
- `atlas/standards/java-services.md` — ``shared-java-events`` → `[data-lib-events](atlas/repos/data-lib-events.md)` (no such file existed)
- `atlas/standards/event-contracts.md` — ``shared-java-events`` → `[data-lib-events](atlas/repos/data-lib-events.md)`
- `atlas/runbooks/sqs-backlog-debugging.md` — ``repos`` → `[repo-catalog](atlas/repo-catalog.md)` + rephrased (no `repos.md` file)
- `atlas/repo-catalog.md` — ``example-service`` → `atlas/repos/_example-service.md`; broken path link ``...`` → ``repos-guide``
- `atlas/repos/repos-guide.md` — ``example-service`` → `atlas/repos/_example-service.md`

**Orphan redirect stubs deleted (13 files + 2 empty dirs):**
- `atlas/decisions/adr-0001-example.md`, `adr-template.md`
- `atlas/onboarding/local-claude-md-template.md`, `maintaining-the-atlas.md`, `new-developer-start-here.md`, `using-claude-with-this-repo.md`
- `atlas/types/` — all 7 files (python-lambda, java-service, glue-job, python-library, java-library, cloudformation-repo, local-claude-md)
- Removed now-empty `atlas/onboarding/` and `atlas/types/` directories

---

## [2026-04-26] structure | Major restructure — repo-types/, onboarding/ to root, _adr-template

- `atlas/types/` → `atlas/repo-types/` — name was unclear; "repo-types" pairs with repo-map/ and repos/; all 7 files recreated, old files redirect; index.md section renamed "Repo types"; CLAUDE.md wikilink table updated
- `atlas/onboarding/` → `onboarding/` (root level) — onboarding is operational meta-content, not compiled atlas knowledge; 3 files recreated at root, old files redirect; CLAUDE.md wikilink table updated
- `atlas/decisions/adr-template.md` → `atlas/decisions/_adr-template.md` — `_` prefix marks it as a scaffold template; old file redirects; index.md and adr-0001-example.md updated
- `atlas/repo-types/local-claude-md.md` — type paths updated from `atlas/types/` to `atlas/repo-types/`
- `atlas/onboarding/using-claude-with-this-repo.md` — template path updated to `atlas/repo-types/local-claude-md.md`
- `atlas/onboarding/maintaining-the-atlas.md` — `staging/skills/` step added to weekly pass
- `.claude/skills/weekly-lint/SKILL.md` — path updated to `atlas/onboarding/maintaining-the-atlas.md`
- `staging/new-repos/_template.md` — wikilink updated to `[local-claude-md](claude-assets/repo-guides/local-claude-md.md)`

## [2026-04-26] structure | Structural cleanup — moves, merges, renames

- `atlas/onboarding/local-claude-md-template.md` → `atlas/types/local-claude-md.md` — template is Claude runtime tooling, not onboarding material; old file redirects
- `atlas/repos/example-service.md` → `atlas/repos/_example-service.md` — prefix marks it as a template, not a real repo; old file redirects; all wikilinks updated
- `atlas/decisions/adr-0001-example.md` — example merged into `adr-template.md` as a condensed section; old file redirects
- `index.md` — updated links for all above; `local-claude-md` moved to Repo type templates section; `adr-0001-example` removed as standalone entry
- `staging/README.md` — clarified that `skills/` compiles to `.claude/skills/`, not atlas
- `atlas/onboarding/maintaining-the-atlas.md` — added `skills/` to step 2 subfolder list
- `CLAUDE.md` — updated ``local-claude-md-template`` → `[local-claude-md](claude-assets/repo-guides/local-claude-md.md)`

## [2026-04-26] structure | New repo flow clarified — trigger, CLAUDE.md creation, and onboarding

- `atlas/onboarding/using-claude-with-this-repo.md` — added "New repo — no local CLAUDE.md yet" section: how to create local CLAUDE.md via central template before any staging entry exists
- `staging/new-repos/README.md` — trigger changed from repo creation to first meaningful master merge; noted local CLAUDE.md may already exist at compile time
- `staging/new-repos/_template.md` — "Generated local CLAUDE.md" section updated: handles both cases (CLAUDE.md exists → update repo path; doesn't exist → create from template)
- `staging/mr-summaries/README.md` — added note: first meaningful MR for a new repo should also create a `staging/new-repos/` entry

## [2026-04-26] structure | claude-assets trimmed; guide added for skills and prompts

- `claude-assets/prompts-catalog.md` — rewritten: removed explanatory prose, now a clean index matching skills-catalog format; added note pointing to `claude-assets/prompts/` as home for prompt files
- `claude-assets/claude-assets-guide.md` — new: maintainer rules for adding/approving skills and prompts, entry formats, skill-vs-prompt decision rule
- `index.md` — added `claude-assets-guide` to Claude assets section

## [2026-04-26] structure | staging/skills/ added; weekly-lint updated to review skill proposals

- `staging/skills/` — new folder: README + `_template.md` for proposing new skills
- `staging/README.md` — added `skills/` to subfolder list
- `.claude/skills/weekly-lint/SKILL.md` — updated: added step 6 to check `staging/skills/`, classify each proposal (duplicate/overlap/contradiction/new), and output human-actionable recommendations; does not create skill files

## [2026-04-26] structure | Skills added to .claude/skills/; type templates updated with relevant skills

- `.claude/skills/` — new directory with 5 skill definitions: `ingest-staging`, `weekly-lint`, `new-repo-compile`, `aws-test-plan`, `repo-impact`
- `claude-assets/skills-catalog.md` — rewritten from placeholder catalog to index of actual skills in `.claude/skills/`
- All 6 type templates (`python-lambda`, `java-service`, `glue-job`, `python-library`, `java-library`, `cloudformation-repo`) — added `## Relevant skills` section pointing to applicable skills by name
- `CLAUDE.md` — added `## Skills` section: auto-load behavior, invocation, catalog pointer

## [2026-04-26] structure | Type files moved, folder guides renamed, Obsidian link discipline applied

- `atlas/onboarding/types/` → `atlas/types/` — type files are Claude runtime context, not onboarding material
- `atlas/types/cloudformation-repo.md` — renamed from `cloudformation.md` to avoid wikilink collision with `atlas/standards/cloudformation.md`
- All 6 type files updated with `Related` section (wikilinks for Obsidian graph edges)
- `atlas/repos/README.md` → `atlas/repos/repos-guide.md` — follows CLAUDE.md rule against README naming in atlas
- `atlas/flows/README.md` → `atlas/flows/flows-guide.md` — same rule
- `atlas/repos/example-service.md` — placeholder wikilinks (``upstream-repo-a`` etc.) replaced with backtick placeholders; real links kept
- `index.md` — updated type template paths, fixed repos/flows guide links, added new-repos/ and deprecations/ to staging section, updated cloudformation-repo entry
- `atlas/onboarding/local-claude-md-template.md` — updated type paths
- `staging/new-repos/_template.md` — updated type path in generated CLAUDE.md section

## [2026-04-26] structure | Type templates added; local CLAUDE.md redesigned around type-first routing

- `atlas/onboarding/types/` — new directory with 6 type files: python-lambda, java-service, glue-job, python-library, java-library, cloudformation. Each contains: mandatory pre-task reads, shared library prescriptions ("use X not Y"), runbook paths, relevant concepts.
- `atlas/onboarding/local-claude-md-template.md` — redesigned: minimal structure (commands, type pointer, repo page pointer, dependencies and usage). Type template is the primary routing mechanism.
- `staging/new-repos/_template.md` — updated: includes a "Generated local CLAUDE.md" section so local CLAUDE.md creation is a direct output of compilation.
- `atlas/repos/example-service.md` — routing section updated: explicit paths, references type template, drops reads covered by type.
- `atlas/repos/dl-ingestion-lambdas.md`, `dl-quality-checks-lambda.md`, `curated-etl-glue.md`, `lineage-service.md`, `analytics-api.md` — routing sections updated: explicit paths, wikilinks removed, reads covered by type template removed.
- `index.md` — added Repo type templates section.

## [2026-04-26] structure | Design gaps resolved from proposal review conversation

Changes made to address gaps identified in the proposal and follow-up conversation:

- `CLAUDE.md` — rewrote to add: staging-only entry point rule, high-impact escape hatch definition, wikilink resolution folder map, `--add-dir` CLAUDE.md loading caveat, secrets policy, dependency usage pattern, updated routing for coding tasks vs. index, reference to `maintaining-the-atlas`
- `atlas/onboarding/local-claude-md-template.md` — new: template for local repo CLAUDE.md files including `Dependencies and usage` section
- `atlas/onboarding/maintaining-the-atlas.md` — new: full weekly pass process, succession guidance, compile criteria
- `local CLAUDE.md Dependencies and usage sections` — new: derived file skeleton collecting consumer `Dependencies and usage` sections from local CLAUDE.md files
- `atlas/dependency-map.md` — updated: added `Public contract` and `Internal` sections per library; updated "Before changing" steps to include public contract check and consumer CLAUDE.md reading
- `atlas/dependency-map.md` — updated: added explicit instruction that this page identifies candidates only; reading consumer local CLAUDE.md is the second step for precise impact analysis
- `atlas/repos/example-service.md` — updated: added note pointing to `local-claude-md-template` for the dependency usage section
- `staging/README.md` — updated: added `new-repos/` and `deprecations/` to subfolder list
- `staging/new-repos/` — new folder: README + `_template.md`
- `staging/deprecations/` — new folder: README + `_template.md`
- `index.md` — updated: added `usage-summaries`, `local-claude-md-template`, `maintaining-the-atlas`

## [2026-04-24] structure | Initial scaffold created
- Created three-layer layout: `staging/`, `atlas/`, `claude-assets/`.
- Added `CLAUDE.md`, `index.md`, `log.md`.
- Added starter pages for standards, runbooks, concepts, onboarding, and example repo/flow.
- Added staging folders with per-folder READMEs describing conventions.
