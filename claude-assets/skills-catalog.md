# Skills catalog

Team skills live in `.claude/skills/` and are auto-loaded via `--add-dir`. Invoke as `/skill-name`.

For adding or approving skills: [[claude-assets-guide]].

---

## Atlas maintenance

| Skill | Purpose | When to use |
|---|---|---|
| `/ingest-staging` | Curate a staging file into the appropriate durable layer and update `log.md` | After dropping a raw note or proposal into `staging/`; same-day for high-impact items |
| `/weekly-lint` | Full weekly pass - triage staging files, scan curated layers for outdated or broken content, review skill and prompt proposals modified since the last lint | Once a week by the curated-layer maintainer |
| `/new-repo-compile` | Compile a `staging/new-repos/` entry into repo pages and repo-map pages, then remind the developer to update their local CLAUDE.md pointer | When a new repo staging entry is ready to promote |

## Development

| Skill | Purpose | When to use |
|---|---|---|
| `/aws-test-plan` | Generate a post-deploy AWS validation checklist for the current change | Before merging any change affecting AWS runtime behavior (Lambda, SQS, Glue, CloudFormation) |
| `/repo-impact` | List the candidate affected repos for a proposed change and confirm usage only where consumer coverage exists | Before changing a shared library public contract, an event schema, or a cross-repo API |
