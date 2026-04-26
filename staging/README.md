# staging/ - raw source material

All new information and Claude asset proposals land here first. Do not write directly to curated layers.

Files may be messy, contradictory, or incomplete. Do not rewrite them. Curate them into the right durable destination:

- `atlas/` for compiled engineering knowledge
- `.claude/skills/` for approved executable Claude workflows
- `claude-assets/` for approved reusable prompts and asset catalogs

Naming: `YYYY-MM-DD-short-kebab-title.md`

## Subfolders

- `new-repos/` - new repo onboarding entries -> compiled into `atlas/repos/`
- `deprecations/` - repo retirement entries -> triggers atlas archival
- `skills/` - proposed new skills -> reviewed during weekly lint; approved proposals promoted to `.claude/skills/` and `skills-catalog.md`
- `prompts/` - proposed reusable prompts -> reviewed during weekly lint; approved proposals promoted to `claude-assets/prompts/` and `prompts-catalog.md`
- `confluence/` - Confluence exports
- `repo-findings/` - discoveries made while working in a repo
- `incidents/` - incident notes and postmortems
- `meeting-notes/` - design and architecture meetings
- `decisions/` - rough decision notes before they become ADRs
- `mr-summaries/` - atlas-relevant MR notes only (see that folder's README)
- `architecture-notes/` - rough architecture drafts
- `aws-findings/` - AWS/runtime/deployment discoveries
- `chat-discussions/` - important Slack/Teams threads
- `debugging-notes/` - debugging sessions worth preserving

## Curation rule

A raw file has been curated when:
1. Its durable content is in the appropriate curated destination.
2. A `log.md` entry links to the durable files touched.
3. Related atlas pages, skills catalogs, or prompt catalogs have been updated.

Raw files stay in `staging/` after curation - they are the audit trail.
