---
name: repo-impact
description: Identify candidate affected repos for a proposed change and confirm usage where consumer coverage exists
user-invocable: true
---

Perform a cross-repo impact analysis for a proposed change.

If the user did not describe the change, ask: what is changing — a shared library class/method, an event schema field, an API endpoint, or an infrastructure export?

State up front whether coverage is complete enough for a precise answer. If `usage-summaries.md` still contains `_not yet collected_` rows or candidate consumers are missing accessible local `CLAUDE.md` files, say that the result is partial and that unknown consumers stay in "Possibly affected."

Steps:
1. Read `atlas/dependency-map.md` from the central context. Identify the candidate consumer set for the element being changed.
2. Read `local CLAUDE.md Dependencies and usage sections` for a quick cross-reference of which consumers use what.
3. Treat blank cells or `_not yet collected_` rows in `usage-summaries.md` as missing coverage, not as evidence that a consumer does not use the element.
4. For each candidate consumer, check if a local `CLAUDE.md` with a `Dependencies and usage` section is accessible. If so, check whether the specific element being changed is listed.
5. Report in three buckets:
   - **Confirmed affected** — consumer's `Dependencies and usage` explicitly lists the changed element.
   - **Possibly affected** — consumer is in dependency-map but no local CLAUDE.md is accessible to verify.
   - **Not affected** — consumer's `Dependencies and usage` does not include the changed element.
6. For confirmed-affected consumers, note the specific usage (which class, method, or field they use).
7. If the result depends on incomplete coverage, add a short "Coverage gaps" section naming the missing consumer repos or stale summary rows.

Do not read consumer codebases. Use only dependency-map.md, usage-summaries.md, and local CLAUDE.md files.
Do not speculate. If you cannot verify, place the repo in "Possibly affected."
