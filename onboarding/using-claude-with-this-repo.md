# Using Claude with the central context

Related: [[CLAUDE]], [[new-developer-start-here]]

## New repo - no local CLAUDE.md yet

Use the command-line flag (not `/add-dir` in-session - skills will not load that way):

```
cd ~/company/repos/<repo-name>
claude --add-dir ~/company/engineering-context
```

Then ask Claude to create the local `CLAUDE.md`:

```
Create a local CLAUDE.md for this repo using the template at
atlas/repo-guides/local-claude-md.md.
Read the repo's build and dependency files to infer commands and type.
Cross-reference atlas/repo-map/shared-libraries.md to identify which
team-owned libraries are already declared as dependencies.
Ask me to confirm the type and any consumed events before writing the file.
```

Claude reads the template, reads the repo, fills in what it can detect, confirms the rest with you. The local `CLAUDE.md` is written. From that point the type template is active and you have full standards, library prescriptions, runbooks, and skills.

No staging entry is needed at this point. The repo enters `staging/new-repos/` only when the first meaningful MR merges to master.

---

## Starting a session

**Always use the command-line flag - not the in-session `/add-dir` command.**

`--add-dir` at startup loads skills as slash commands. `/add-dir` in-session grants file access only - skills will not load.

```
cd ~/company/repos/<repo-name>
claude --add-dir ~/company/engineering-context
```

Claude has read access to both:

- the local repo (primary working directory)
- the central engineering context (attached)

Skills from the central repo (e.g. `/aws-test-plan`, `/repo-impact`) are available immediately as slash commands.

If Claude reports that the central context path is unavailable, stop and restart with `--add-dir`. Do not continue with central-context-dependent work from local files alone.

## Typical asks

### Planning a change
> Plan this change using local repo context and central engineering context. Do not edit files yet.

Claude will route via the local `CLAUDE.md`, the repo's page in `atlas/repos/` if it exists, and any linked flows/standards.

### Impact analysis
> What else is affected if I change the `data.quality.validated` event schema?

Claude should read [[dependency-map]], [[event-contracts]], and the pages for producers/consumers of that event.
Precision depends on current consumer `Dependencies and usage` coverage in local `CLAUDE.md` files and [[usage-summaries]]. Without that coverage, expect a candidate set rather than a definitive break list.

### AWS test plan
> Produce an AWS test plan for this change based on our aws-testing standard.

Claude reads [[aws-testing]], the repo's "AWS context" section, and the relevant flow page.

### Runbook execution
> Walk me through debugging this Lambda error using the team's runbook.

Claude follows [[lambda-failure-debugging]] step by step.

### After the task - capture learnings
> Capture durable learnings from this task into the right staging folder.

Claude drafts a note in the appropriate `staging/` folder. You review and commit. If the learning is high-impact or already confirmed, ask Claude to curate that staging note into the right durable layer and update `log.md`.

## Reading vs. writing

By default, Claude **reads** the central context and **writes** central-context changes only to `staging/` - raw notes or proposals. Curation into `atlas/`, `.claude/skills/`, or `claude-assets/` happens only from an existing staging note, either on demand or during the weekly lint.

If you want Claude to update a durable central file after a task:

1. Ask Claude to draft the note in the right `staging/` folder.
2. Review the staging note.
3. Then ask:
   > Curate `staging/<folder>/<file>.md` into the appropriate durable layer and update `log.md`.

Review the diff carefully. Durable edits are long-lived; staging notes are cheap.

## What Claude should NOT do

- Read every file in the central context before answering.
- Create new atlas pages when an existing one fits.
- Rewrite `staging/` files.
- Duplicate content across atlas pages.
- Write directly to `atlas/`, `.claude/skills/`, or `claude-assets/` without a staging entry.

If Claude does any of these, redirect it to [[CLAUDE]].

## In a future monorepo

When the team moves to a monorepo, the same rules apply. The central context lives at `engineering-context/` inside the monorepo. Starting Claude from inside `services/<name>/` gets you the right local `CLAUDE.md`; the top-level `CLAUDE.md` is a router pointing to `engineering-context/index.md` for shared knowledge.
