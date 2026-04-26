# atlas/repos/ — repo pages

One page per repo. Named after the repo, not `README.md`, so Obsidian's graph stays clean.

Related: [[repo-catalog]]

## Page template

See [[_example-service]] for the working template. Required sections:

- Summary
- Type and owner
- Responsibilities
- Connections (upstream / downstream / shared libraries)
- Events / APIs (if any)
- AWS context (if any)
- Known gotchas
- Related docs (flows, standards, runbooks)
- Claude routing

Optional: Alerts, Deployment notes, Environment-specific quirks.

## Naming

- File: `<repo-name>.md` — match the repo name exactly.
- Wikilink: `[[<repo-name>]]`.

## When to add a repo page

Only via `staging/new-repos/` — see [[maintaining-the-atlas]].

## When to split into a folder

If a single page exceeds ~300–400 lines, split it:

```
atlas/repos/<repo-name>/
  <repo-name>.md       ← overview (main note, keeps the repo name)
  connections.md
  aws.md
  known-gotchas.md
```
