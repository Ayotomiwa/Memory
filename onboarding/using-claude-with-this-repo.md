# Using Claude with the central context

Related: [CLAUDE](../CLAUDE.md), [new-developer-start-here](new-developer-start-here.md)

## Decision tree

### Repo has no local `CLAUDE.md` yet and is not onboarded
1. Start Claude with the central context attached:
   ```bash
   claude --add-dir ~/company/engineering-context
   ```
2. Ask Claude to create a local `CLAUDE.md` from [local-claude-md](../claude-assets/repo-guides/local-claude-md.md).
3. Claude reads the repo, infers commands and type, and asks you to confirm the type and any consumed events before writing the file.
4. After that, the repo uses its new local `CLAUDE.md` plus the central context.

### Repo already has a local `CLAUDE.md`
1. Start Claude with `--add-dir ~/company/engineering-context`.
2. Claude reads the local `CLAUDE.md`, the repo guide, and the repo page if it exists.
3. Use Claude normally for tasks.
4. If shared-library usage, event fields, or internal endpoints change, update the local `CLAUDE.md` in the same MR.

### Repo has no local `CLAUDE.md` but is already onboarded here
1. Start Claude with `--add-dir ~/company/engineering-context`.
2. Create the local `CLAUDE.md` from [local-claude-md](../claude-assets/repo-guides/local-claude-md.md).
3. Point `Repo page:` at the existing atlas page:
   ```md
   Repo page: atlas/repos/<repo-name>.md
   ```
4. Claude can then use the atlas page immediately, along with the type guide and local code.

## New repo - no local CLAUDE.md yet

Use the command-line flag (not `/add-dir` in-session - skills will not load that way):

```
cd ~/company/repos/<repo-name>
claude --add-dir ~/company/engineering-context
```

Then ask Claude to create the local `CLAUDE.md`:

```
Create a local CLAUDE.md for this repo using the template at
claude-assets/repo-guides/local-claude-md.md.
Read the repo's build and dependency files to infer commands and type.
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

Claude should read [dependency-map](../atlas/dependency-map.md) and [event-contracts](../atlas/standards/event-contracts.md), then the pages for producers/consumers of that event.

### AWS test plan
> Produce an AWS test plan for this change based on our aws-testing standard.

Claude reads [aws-testing](../atlas/standards/aws-testing.md), the repo's "AWS context" section, and the relevant flow page.

### Runbook execution
> Walk me through debugging this Lambda error using the team's runbook.

Claude follows [lambda-failure-debugging](../atlas/runbooks/lambda-failure-debugging.md) step by step.

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

If Claude does any of these, redirect it to [CLAUDE](../CLAUDE.md).

## In a future monorepo

When the team moves to a monorepo, the same rules apply. The central context lives at `engineering-context/` inside the monorepo. Starting Claude from inside `services/<name>/` gets you the right local `CLAUDE.md`; the top-level `CLAUDE.md` is a router pointing to `engineering-context/index.md` for shared knowledge.
