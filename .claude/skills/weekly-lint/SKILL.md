---
name: weekly-lint
description: Run the weekly curated-layer maintenance pass - ingest staging files, scan atlas for outdated or broken content, and review proposed skills and prompts
user-invocable: true
---

Run the weekly curated-layer maintenance pass. Full process: atlas/onboarding/maintaining-the-atlas.md.

Steps:
1. Read `log.md`. Find the date of the last `lint` entry.
2. List all files under `staging/` modified since that date, grouped by subfolder.
3. For each non-skill and non-prompt staging file, decide: **ingest** (update curated pages now), **defer** (not ready or incomplete), or **discard** (not relevant to curated memory). State the decision and reason for each file. Discard means "do not compile"; keep the raw staging file as audit trail.
4. Ingest each non-skill and non-prompt file marked for ingest using the standard curation process (read file -> update durable files in place -> add wikilinks or catalog entries -> flag contradictions -> do not modify staging file).
5. Scan `atlas/` for:
   - **Orphan pages** - pages not linked from index.md or any other atlas page.
   - **Outdated pages** - references to deprecated repos, removed services, or inactive standards.
   - **Broken wikilinks** - ``page-name`` references where no matching file exists.
6. For each proposed skill file under `staging/skills/` that was modified since the last lint:
   a. Read the proposed skill instructions.
   b. Read all existing `.claude/skills/*/SKILL.md` files.
   c. Classify the proposal as one of:
      - **Duplicate** - same purpose as an existing skill; name the existing skill.
      - **Overlap** - similar purpose but distinct enough to coexist; describe the difference.
      - **Contradiction** - instructions conflict with an existing skill; describe the conflict.
      - **New** - no meaningful overlap found.
   d. Output a recommendation: promote as-is, merge with existing skill (specify which), reject (specify why), or needs human review.
   e. Do not create or modify any `.claude/skills/` file - output recommendations only.
7. For each proposed prompt file under `staging/prompts/` that was modified since the last lint:
   a. Read the proposed prompt.
   b. Read `claude-assets/prompts-catalog.md` and any existing prompt source files.
   c. Check whether an existing skill covers the same task; if so, prefer the skill unless the prompt has a distinct use.
   d. Classify the proposal as Duplicate, Overlap, Contradiction, or New.
   e. Output a recommendation: promote as-is, merge with an existing prompt or skill, reject, or needs human review.
   f. Do not create or modify any `claude-assets/` file - output recommendations only.
8. Check `claude-assets/skills-catalog.md` and `claude-assets/prompts-catalog.md` for source paths that do not exist.
9. Append a `lint` entry to `log.md`: today's date, summary of staging files processed, atlas issues found, asset catalog issues found, skill and prompt proposals reviewed and their classifications.

Report all findings before making any atlas changes. Ask for confirmation before deleting or removing content from curated files.
