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

## [2026-04-26] structure | Contradictions and terminology alignment pass

- `onboarding/maintaining-the-atlas.md`, `.claude/skills/weekly-lint/SKILL.md` - aligned `discard` semantics with staging audit-trail policy (do not delete staging files)
- `atlas/repo-map/dependency-map.md`, `atlas/repo-map/shared-libraries.md`, `atlas/repo-map/usage-summaries.md`, `atlas/repos/data-platform-pylib.md` - removed incorrect `lineage-service` dependency on `data-platform-pylib`
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
- Atlas issues found: orphan page `atlas/repos/_archived/_archive-guide.md` (no inbound wikilinks from `index.md` or `atlas/`); no broken wikilinks in `atlas/`; no missing repo pages vs `atlas/repo-map/repo-catalog.md`
- Claude assets issues found: all `skills-catalog` and `prompts-catalog` source targets exist
- Skill proposals reviewed: none (only `staging/skills/README.md` and `staging/skills/_template.md`)
- Prompt proposals reviewed: none (only `staging/prompts/README.md` and `staging/prompts/_template.md`)
- Additional inconsistency outside curated scan scope: this log's latest structure entry references `atlas/repos/example-service.md`; current file is `atlas/repos/_example-service.md`

## [2026-04-26] structure | Direct wording pass

- `onboarding/using-claude-with-this-repo.md`, `.claude/skills/weekly-lint/SKILL.md`, `claude-assets/skills-catalog.md`, `onboarding/maintaining-the-atlas.md`, `staging/chat-discussions/README.md`, `staging/confluence/README.md` - tightened current-state wording in live guidance
- `atlas/repos/_example-service.md` - removed redundant template pointer; use [[_example-service]]

## [2026-04-26] structure | Local bootstrap and curated intake tightened

- `atlas/repo-guides/local-claude-md.md` - added required startup routing for generated local `CLAUDE.md` files and central-context availability handling
- `onboarding/using-claude-with-this-repo.md` - documented durable-layer curation from staging
- `.claude/skills/ingest-staging/SKILL.md` - documented staging-to-durable-layer curation
- `claude-assets/prompts/` - added missing source files referenced by `prompts-catalog.md`

## [2026-04-26] structure | Staging set as single intake for all curated layers

- `CLAUDE.md`, `staging/README.md`, `onboarding/maintaining-the-atlas.md` - documented that `staging/` feeds `atlas/`, `.claude/skills/`, and `claude-assets/`
- `staging/prompts/` - added proposal queue and template for reusable prompts
- `claude-assets/claude-assets-guide.md`, `claude-assets/skills-catalog.md`, `index.md` - documented prompt and skill maintenance flow
- `.claude/skills/weekly-lint/SKILL.md` - added prompt proposal review and asset catalog target checks

## [2026-04-26] structure | Workflow docs aligned; event granularity removed; skill drift fixed

- `CLAUDE.md`, `index.md`, `onboarding/using-claude-with-this-repo.md`, `onboarding/maintaining-the-atlas.md` — aligned on staging-first compilation, removed standalone event-note routing, clarified archived repo path handling
- `atlas/repo-map/dependency-map.md`, `atlas/flows/raw-to-curated-flow.md`, `atlas/repos/data-events.md`, `atlas/repos/ingestion-lambdas.md`, `atlas/repos/quality-checks-lambda.md`, `atlas/repos/curated-etl-glue.md`, `atlas/repos/lineage-service.md` — kept event names inline as supporting detail rather than first-class atlas pages
- `atlas/repo-map/repo-catalog.md`, `atlas/repo-map/usage-summaries.md`, `atlas/repos/_page-template.md` — aligned repo-page and impact-analysis guidance with the repo/flow-level event model
- `.claude/skills/new-repo-compile/SKILL.md`, `.claude/skills/repo-impact/SKILL.md`, `.claude/skills/weekly-lint/SKILL.md`, `claude-assets/skills-catalog.md` — fixed rename drift and matched the documented process
- `staging/new-repos/README.md`, `staging/new-repos/_template.md`, `staging/deprecations/README.md` — updated compilation and archival checklists
- `atlas/repos/_archived/_archive-guide.md` — documented how archived repo pages are stored

## [2026-04-26] structure | atlas/repo-types/ → atlas/repo-guides/; repos-guide.md → _page-template.md

- `atlas/repo-types/` renamed to `atlas/repo-guides/` — "repo guides" clarifies purpose (pre-task context loaders) vs. "repo types" which implied classification
- `atlas/repos/repos-guide.md` renamed to `atlas/repos/_page-template.md` — more specific name; `_` prefix sorts it first; avoids collision with `repo-guides/`
- `index.md` — section "Repo types" → "Repo guides"; added one-line description; updated 7 path references; `[[repos-guide]]` → `[[_page-template]]`
- `CLAUDE.md` — wikilink table: "Repo type" → "Repo guide", path updated
- `atlas/repo-guides/local-claude-md.md` — 7 internal path references updated
- `atlas/repo-map/repo-catalog.md` — `[[repos-guide]]` → `[[_page-template]]`
- `onboarding/using-claude-with-this-repo.md` — path reference updated

## [2026-04-26] lint | First weekly pass — no staging content; 6 wikilink fixes; 13 orphan stubs deleted

**Staging:** All 15 non-skills staging files are READMEs/templates — no ingest actions. No skill proposals in `staging/skills/`.

**Wikilink fixes (5 files):**
- `atlas/standards/java-services.md` — `[[shared-java-events]]` → `[[data-events]]` (no such file existed)
- `atlas/standards/event-contracts.md` — `[[shared-java-events]]` → `[[data-events]]`
- `atlas/runbooks/sqs-backlog-debugging.md` — `[[repos]]` → `[[repo-catalog]]` + rephrased (no `repos.md` file)
- `atlas/repo-map/repo-catalog.md` — `[[example-service]]` → `[[_example-service]]`; broken path link `[[atlas/repos/README|...]]` → `[[repos-guide]]`
- `atlas/repos/repos-guide.md` — `[[example-service]]` → `[[_example-service]]`

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
- `onboarding/using-claude-with-this-repo.md` — template path updated to `atlas/repo-types/local-claude-md.md`
- `onboarding/maintaining-the-atlas.md` — `staging/skills/` step added to weekly pass
- `.claude/skills/weekly-lint/SKILL.md` — path updated to `onboarding/maintaining-the-atlas.md`
- `staging/new-repos/_template.md` — wikilink updated to `[[local-claude-md]]`

## [2026-04-26] structure | Structural cleanup — moves, merges, renames

- `atlas/onboarding/local-claude-md-template.md` → `atlas/types/local-claude-md.md` — template is Claude runtime tooling, not onboarding material; old file redirects
- `atlas/repos/example-service.md` → `atlas/repos/_example-service.md` — prefix marks it as a template, not a real repo; old file redirects; all wikilinks updated
- `atlas/decisions/adr-0001-example.md` — example merged into `adr-template.md` as a condensed section; old file redirects
- `index.md` — updated links for all above; `local-claude-md` moved to Repo type templates section; `adr-0001-example` removed as standalone entry
- `staging/README.md` — clarified that `skills/` compiles to `.claude/skills/`, not atlas
- `atlas/onboarding/maintaining-the-atlas.md` — added `skills/` to step 2 subfolder list
- `CLAUDE.md` — updated `[[local-claude-md-template]]` → `[[local-claude-md]]`

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
- `atlas/repos/example-service.md` — placeholder wikilinks (`[[upstream-repo-a]]` etc.) replaced with backtick placeholders; real links kept
- `index.md` — updated type template paths, fixed repos/flows guide links, added new-repos/ and deprecations/ to staging section, updated cloudformation-repo entry
- `atlas/onboarding/local-claude-md-template.md` — updated type paths
- `staging/new-repos/_template.md` — updated type path in generated CLAUDE.md section

## [2026-04-26] structure | Type templates added; local CLAUDE.md redesigned around type-first routing

- `atlas/onboarding/types/` — new directory with 6 type files: python-lambda, java-service, glue-job, python-library, java-library, cloudformation. Each contains: mandatory pre-task reads, shared library prescriptions ("use X not Y"), runbook paths, relevant concepts.
- `atlas/onboarding/local-claude-md-template.md` — redesigned: minimal structure (commands, type pointer, repo page pointer, dependencies and usage). Type template is the primary routing mechanism.
- `staging/new-repos/_template.md` — updated: includes a "Generated local CLAUDE.md" section so local CLAUDE.md creation is a direct output of compilation.
- `atlas/repos/example-service.md` — routing section updated: explicit paths, references type template, drops reads covered by type.
- `atlas/repos/ingestion-lambdas.md`, `quality-checks-lambda.md`, `curated-etl-glue.md`, `lineage-service.md`, `analytics-api.md` — routing sections updated: explicit paths, wikilinks removed, reads covered by type template removed.
- `index.md` — added Repo type templates section.

## [2026-04-26] structure | Design gaps resolved from proposal review conversation

Changes made to address gaps identified in the proposal and follow-up conversation:

- `CLAUDE.md` — rewrote to add: staging-only entry point rule, high-impact escape hatch definition, wikilink resolution folder map, `--add-dir` CLAUDE.md loading caveat, secrets policy, dependency usage pattern, updated routing for coding tasks vs. index, reference to `maintaining-the-atlas`
- `atlas/onboarding/local-claude-md-template.md` — new: template for local repo CLAUDE.md files including `Dependencies and usage` section
- `atlas/onboarding/maintaining-the-atlas.md` — new: full weekly pass process, succession guidance, compile criteria
- `atlas/repo-map/usage-summaries.md` — new: derived file skeleton collecting consumer `Dependencies and usage` sections from local CLAUDE.md files
- `atlas/repo-map/shared-libraries.md` — updated: added `Public contract` and `Internal` sections per library; updated "Before changing" steps to include public contract check and consumer CLAUDE.md reading
- `atlas/repo-map/dependency-map.md` — updated: added explicit instruction that this page identifies candidates only; reading consumer local CLAUDE.md is the second step for precise impact analysis
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
