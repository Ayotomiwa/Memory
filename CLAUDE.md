# CLAUDE.md - Operating Rules for the Engineering Context Repo

- `staging/` = raw source material and proposals (evidence, never rewrite)
- `atlas/` = compiled engineering knowledge
- `.claude/skills/` = approved executable Claude workflows
- `claude-assets/` = approved reusable Claude prompts and asset catalogs
- `CLAUDE.md` = operating rules (this file)

---

## Layers

### `staging/`
- All new information lands here first. No exceptions.
- Files may be messy, contradictory, or incomplete - expected.
- Do not rewrite staging files. Curate them into the appropriate durable layer.

### `atlas/`
- Update pages in place. Do not create a new page if a suitable one exists.
- Link between pages using Obsidian wikilinks: `[[page-name]]`.
- One note per meaningful thing: repo, service, flow, runbook, standard, decision, concept.

### `.claude/skills/`
- Approved skills live here as `.claude/skills/<name>/SKILL.md`.
- Skill proposals start in `staging/skills/` and are reviewed during weekly lint.
- Human approval is required before promoting a proposed skill.

### `claude-assets/`
- Approved reusable prompts and asset catalogs live here.
- Prompt proposals start in `staging/prompts/` and are reviewed during weekly lint.

---

## Staging is the only entry point

Nothing enters a curated layer directly. New knowledge, skills, prompts, and asset proposals go through `staging/` first, then Claude curates them into the right destination:

- `atlas/` for compiled engineering knowledge
- `.claude/skills/` for approved executable skills
- `claude-assets/` for approved reusable prompts and asset catalogs

**High-impact - compile same-day, do not wait for the weekly pass:**
- New repo that other repos already depend on
- Breaking event schema change
- Repo deprecation
- Ownership transfer

Everything else waits for the weekly pass.

---

## Routing

Start from `index.md`. Follow only the links you need.

1. Read `index.md`.
2. Follow 2-5 relevant links.
3. If a repo is involved, read `atlas/repos/<repo>.md`.
4. If the change crosses repos, read `atlas/repo-map/dependency-map.md`.
5. Expand further only if the task requires it.

**For coding tasks from a local repo:** do not start at `index.md`. The local `CLAUDE.md` points directly to the relevant `atlas/repos/<repo>.md`. Follow that pointer.

If you cannot find what you need within ~5 hops, say so rather than reading speculatively.

---

## Wikilink resolution

| Link type | Path |
|---|---|
| Repo | `atlas/repos/<name>.md` |
| Standard | `atlas/standards/<name>.md` |
| Flow | `atlas/flows/<name>.md` |
| Runbook | `atlas/runbooks/<name>.md` |
| Decision | `atlas/decisions/<name>.md` |
| Concept | `atlas/concepts/<name>.md` |
| Repo map | `atlas/repo-map/<name>.md` |
| Repo guide | `atlas/repo-guides/<name>.md` |
| Onboarding | `onboarding/<name>.md` |
| Claude asset | `claude-assets/<name>.md` |

When starting from a local repo with `--add-dir`, build a quick path map across `atlas/**/*.md`, `onboarding/**/*.md`, and `claude-assets/**/*.md` before following links.

Deprecated repo pages may live under `atlas/repos/_archived/<name>.md`. Keep the basename unchanged so existing repo-name wikilinks continue to resolve after archival.

---

## Curating staging material

1. Read the raw file.
2. Identify the durable destination: `atlas/`, `.claude/skills/`, or `claude-assets/`.
3. Update existing durable files in place where possible.
4. Add wikilinks or catalog entries to related pages.
5. If the source contradicts existing curated content, add a `> [!warning] Contradiction` callout where applicable and flag it in the log; do not silently overwrite.
6. Append an entry to `log.md`: date, one-line summary, pages touched.
7. Leave the raw file in `staging/` untouched.

---

## Capturing learnings after a task

Write a short note to the appropriate `staging/` subfolder if the task revealed:
- A non-obvious cross-repo connection
- An AWS/runtime behavior that would surprise a future engineer
- A recurring failure pattern
- A reusable standard from an MR review

Naming: `YYYY-MM-DD-short-kebab-title.md`.

---

## Weekly lint

Full process: [[maintaining-the-atlas]].

1. List `staging/` files modified since the last `lint` entry in `log.md`.
2. For each non-skill and non-prompt file: ingest, defer, or discard.
3. For each `staging/skills/` proposal: classify it and recommend promote / merge / reject / human review.
4. For each `staging/prompts/` proposal: classify it and recommend promote / merge / reject / human review.
5. Scan curated layers for duplicates, orphan pages, outdated pages, broken wikilinks, and missing catalog targets.
6. Log findings in `log.md` under a `lint` entry.

---

## Skills

Team skills live in `.claude/skills/` in this repo. They are auto-loaded when a developer adds this repo via `--add-dir` - no manual step needed.

Skills are invoked as `/skill-name`. Full index with descriptions and when-to-use: `claude-assets/skills-catalog.md`.

When asked which skills are available for a task, read `claude-assets/skills-catalog.md`.

---

## Central vs. local `CLAUDE.md`

**Central (this repo):**
- Team-wide standards
- Cross-repo dependency maps
- Flows that span services
- Shared runbooks
- ADRs
- Team-wide concepts
- Skills and prompts catalogue

**Local repo `CLAUDE.md`:**
- Build/test/lint commands
- Local dev setup
- Repo-specific quirks
- Pointer to `atlas/repos/<repo>.md`
- **`Dependencies and usage` section** - which events this repo consumes and which fields it reads, which shared library classes/methods it calls. This does not belong in the atlas; it lives next to the code. See [[local-claude-md]].

Local `CLAUDE.md` target length: under ~100 lines. Anything longer belongs in `atlas/repos/<repo>.md`.

---

## Using the central context from a local repo

```
cd ~/company/repos/<repo-name>
claude --add-dir ~/company/engineering-context
```

**`--add-dir` caveat:** the added directory's `CLAUDE.md` is not automatically loaded as project instructions. The local repo's `CLAUDE.md` must explicitly instruct Claude to read central files - do not rely on auto-loading.

Recommended local pointer:
```markdown
## Central engineering context
Path: ~/company/engineering-context
Start with: ~/company/engineering-context/atlas/repos/<repo-name>.md
```

**Impact analysis for shared library or event changes:**
1. Read `dependency-map.md` -> find the candidate consumer set.
2. For each consumer, read its local `CLAUDE.md` -> `Dependencies and usage` section -> determine if the specific element being changed is actually used.
3. Report which consumers are affected and how.

---

## Monorepo

Structure when the team moves to a monorepo:
```
company-monorepo/
  CLAUDE.md                  <- router only, no instructions
  engineering-context/       <- this repo
  services/<name>/CLAUDE.md  <- local, short
  libraries/<name>/CLAUDE.md <- local, short
```

---

## Obsidian conventions

- Wikilinks for intra-atlas links: `[[page-name]]`, not relative paths.
- Do not name repo pages `README.md` - use the repo name as the filename.
- When a table lists linked entities, add a bullet list of wikilinks below it so graph edges are created.

---

## Contradictions

```
> [!warning] Contradiction
> Source A says X, source B says Y. Unresolved - flagged for team review.
```

Log it in `log.md`. Do not resolve silently. Resolving is a human decision.

---

## Secrets policy

`staging/` must not contain: AWS account IDs, API keys or tokens, credentials, customer names or PII, internal URLs with account IDs. Redact with `[REDACTED]` before saving.

---

## Do not

- Rewrite `staging/` files.
- Create new atlas pages when an existing one fits.
- Read the whole repo before answering.
- Duplicate content across atlas pages - link instead.
- Mirror Confluence verbatim - compile it and keep the source in `staging/confluence/`.
- Write anything directly into `atlas/`, `.claude/skills/`, or `claude-assets/` without a `staging/` entry.
- Put `Dependencies and usage` detail into atlas pages - it belongs in local `CLAUDE.md` files.
