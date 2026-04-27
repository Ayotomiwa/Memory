---
date: YYYY-MM-DD
repo: <repo-name>
created_by: <name>
---

# New repo: <repo-name>

## Purpose
One sentence.

## Repo type
python-lambda | java-service | glue-job | python-library | java-library | cloudformation-repo

## Owner
Team name.

## Repo URL
`<gitlab URL>`

## Language and tooling
e.g., Python 3.12 / uv / pytest

## Commands
- <build>
- <test>
- <lint/check>

## Responsibilities
- Bullet 1
- Bullet 2

## Connections

### Upstream
- <repo or external system> — description

### Downstream
- <repo> — description

### Shared libraries used
- <library> — which parts (e.g., S3Client, event schemas)

## Events

### Publishes
- <event-name> — which fields

### Consumes
- <event-name> — which fields actually read

## AWS resources (if applicable)
- Lambda: <names>
- Queue: <names>
- Stack: <name>
- Log group: <path>

## Known gotchas
Anything non-obvious. Can be empty.

---

## Local CLAUDE.md

Not a compilation output. The developer owns this file.

Once the lead confirms the atlas page has been created, the developer updates their local `CLAUDE.md`:

```
Repo page: atlas/repos/<repo-name>.md
```

(replaces `Repo page: atlas/repos/<repo-name>.md — not yet compiled`)

If no local `CLAUDE.md` exists yet, the developer creates one using [local-claude-md](../../claude-assets/repo-guides/local-claude-md.md).

---

## Atlas pages to update on compilation
- [ ] Create `atlas/repos/<repo-name>.md` from [_repo-template](../../atlas/repos/_repo-template.md)
- [ ] [repo-catalog](../../atlas/repo-catalog.md)
- [ ] [dependency-map](../../atlas/dependency-map.md)
- [ ] Repo ownership captured in [repo-catalog](../../atlas/repo-catalog.md) and the repo page
- [ ] AWS context captured in the repo page, if applicable
- [ ] Shared-library edges captured in [dependency-map](../../atlas/dependency-map.md), if applicable
