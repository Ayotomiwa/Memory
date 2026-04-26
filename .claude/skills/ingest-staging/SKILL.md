---
name: ingest-staging
description: Curate a staging file into the appropriate durable layer and update log.md
user-invocable: true
---

Curate a raw staging file into the right durable layer.

If the user did not provide a staging file path, ask for it before proceeding.

Durable destinations:
- `atlas/` for compiled engineering knowledge
- `.claude/skills/` for approved executable skills
- `claude-assets/` for approved reusable prompts and asset catalogs

Steps:
1. Read the staging file. Do not modify it.
2. Identify the destination based on the staging subfolder and content:
   - `staging/skills/` -> review for promotion to `.claude/skills/` only with human approval.
   - `staging/prompts/` -> review for promotion to `claude-assets/prompts/` only with human approval.
   - Other staging folders -> compile durable engineering knowledge into the appropriate `atlas/` page(s).
3. For atlas knowledge, update existing atlas pages in place. Do not create a new page if a suitable one exists.
4. For approved skills or prompts, create or update the durable source file and the matching catalog entry.
5. Add wikilinks or catalog entries where a meaningful relationship exists.
6. If the source contradicts existing curated content, add a `> [!warning] Contradiction` callout where applicable and do not silently overwrite.
7. Append an entry to `log.md` at the top of the log section: today's date, type `ingest` or `structure`, one-line summary, bullet list of durable files touched.

Report what you updated before and after each step. Stop and ask if you are unsure which durable layer a piece of content belongs to.
