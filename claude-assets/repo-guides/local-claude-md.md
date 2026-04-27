# Local CLAUDE.md - template

Related: [CLAUDE](../../CLAUDE.md), [using-claude-with-this-repo](../../onboarding/using-claude-with-this-repo.md)

Available types:
- `claude-assets/repo-guides/python-lambda.md`
- `claude-assets/repo-guides/java-service.md`
- `claude-assets/repo-guides/glue-job.md`
- `claude-assets/repo-guides/python-library.md`
- `claude-assets/repo-guides/java-library.md`
- `claude-assets/repo-guides/cloudformation-repo.md`

---

```markdown
# <repo-name>

## Commands
- <build command>
- <test command>
- <lint/check command>

## Central context
Path: ~/company/engineering-context
Type: claude-assets/repo-guides/<type>.md
Repo page: atlas/repos/<repo-name>.md

## Required startup routing
Before planning or editing:
1. Confirm the central context path is available. If not, stop and ask the user to restart Claude with `--add-dir ~/company/engineering-context`.
2. Read the repo guide listed in `Type`.
3. Read the repo page listed in `Repo page`, if it exists.
4. If `Repo page` says `not yet compiled` or the file does not exist, continue using the type guide and local code only.
5. For cross-repo changes, read `atlas/dependency-map.md` before editing.

## Dependencies and usage

### <shared-library-name>
- Uses: <class / module / method names>
- Does NOT use: <internal modules>

### <event-name>
- Reads fields: <field1>, <field2>
- Does not use: <field3>

### <service-name> (HTTP)
- Calls: <METHOD /endpoint>
- Does not call: <other endpoints>
```

---

## Rules

**Central context path** - every generated local `CLAUDE.md` must include the exact path used by the team. If Claude cannot access that path in a session, it should stop and ask the user to restart with `--add-dir`.

**Type pointer** - read the type file before any implementation task. It prescribes which shared libraries to use and which standards apply. Do not bypass it.

**Repo page** - add once the atlas page exists. Until then use: `Repo page: atlas/repos/<repo-name>.md - not yet compiled`.

**Required startup routing** - include this section verbatim in every generated local `CLAUDE.md`. It is the reliable bootstrap path because the central `CLAUDE.md` is not automatically loaded as project instructions when attached with `--add-dir`.

**Dependencies and usage:**
- Record every team-owned shared library used (see [dependency-map](../../atlas/dependency-map.md))
- Record every event consumed with the fields actually read
- Record every internal HTTP/gRPC endpoint called
- Do not record third-party libraries or transitive dependencies
- Update in the same MR where the usage changes

**Max length:** ~100 lines. Anything beyond belongs in `atlas/repos/<repo>.md`.
