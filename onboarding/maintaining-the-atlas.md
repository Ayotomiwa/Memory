# Maintaining the curated layers

Weekly pass run by the lead using Claude Code. This pass covers every curated layer fed by `staging/`: `atlas/`, `.claude/skills/`, and `claude-assets/`.

Related: [CLAUDE](../CLAUDE.md), [log](../log.md)

---

## High-impact - compile same-day

- New repo that other repos already depend on (`staging/new-repos/`)
- Breaking event schema change
- Repo deprecation (`staging/deprecations/`)
- Ownership transfer

---

## Weekly pass

### 1. Baseline
Read `log.md`. Find the date of the last `lint` entry.

### 2. List new staging entries
List files added or modified in `staging/` since that date, subfolder by subfolder.

### 3. Triage
For each non-skill and non-prompt file:
- **Ingest** - durable, confirmed knowledge
- **Defer** - unconfirmed or too rough; revisit next week
- **Discard** - redundant or not worth curating now; do not compile, and note the decision in `log.md` (raw file stays in `staging/` as audit trail)

File deferred three weeks running: ingest or discard, do not defer again.

For each file under `staging/skills/`:
- Classify it as **Duplicate**, **Overlap**, **Contradiction**, or **New**
- Output a recommendation: promote as-is, merge with an existing skill, reject, or needs human review
- Do not ingest skill proposals into `atlas/`

For each file under `staging/prompts/`:
- Classify it as **Duplicate**, **Overlap**, **Contradiction**, or **New**
- Output a recommendation: promote as-is, merge with an existing prompt or skill, reject, or needs human review
- Do not ingest prompt proposals into `atlas/`

### 4. Compile ingests
Follow curation rules in [CLAUDE](../CLAUDE.md): read file -> identify the durable destination -> update in place -> flag contradictions.

**`staging/new-repos/` entry:**
1. Create `atlas/repos/<repo>.md` from [_repo-template](../atlas/repos/_repo-template.md).
2. Add to [repo-catalog](../atlas/repo-catalog.md).
3. Add edges to [dependency-map](../atlas/dependency-map.md).

**`staging/deprecations/` entry:**
1. Mark deprecated in [repo-catalog](../atlas/repo-catalog.md).
2. Remove/update edges in [dependency-map](../atlas/dependency-map.md).
3. Move `atlas/repos/<repo>.md` to `atlas/repos/_archived/<repo>.md`.
4. Update pages that link to it.

**`staging/skills/` entry:**
During the weekly pass, classify each proposal and output a recommendation. Human approval is required before any skill is promoted to `.claude/skills/`.

**`staging/prompts/` entry:**
During the weekly pass, classify each proposal and output a recommendation. Human approval is required before any prompt is promoted to `claude-assets/prompts/` and added to [prompts-catalog](../claude-assets/prompts-catalog.md).

### 5. Curated layer health scan
- Duplicates - merge into canonical page
- Orphan pages (no inbound links) - add a link or flag for removal
- Outdated pages (dead repos/services) - update or archive
- Broken links - fix
- Missing catalog targets - flag any `skills-catalog` or `prompts-catalog` entry whose source file does not exist

### 6. Log
```
## [YYYY-MM-DD] lint | <one-line summary>
- Files ingested: N
- Files deferred: N
- Files discarded: N
- Atlas pages updated: <list>
- Claude assets reviewed: <list>
- Issues found: <contradictions, orphans, outdated pages, missing catalog targets>
```

---

## Compile criteria

Ingest when any one of:
- Confirmed by at least one other engineer
- Referenced in a merged MR
- Direct production observation (incident, debugging note, AWS finding)

Do not ingest unverified assumptions.

---

## Succession

1. Outgoing lead: run a final pass, note it in `log.md`.
2. Incoming lead: read this page + last three `log.md` lint entries.
3. Incoming lead: shadow one pass before running solo.
