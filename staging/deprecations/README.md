# staging/deprecations/

Staging entry for every repo being deprecated before atlas pages are updated. Use `_template.md`.

Naming: `YYYY-MM-DD-<repo-name>-deprecation.md`

Deprecations are high-impact and qualify for same-day compilation.

## After the lead compiles it

1. Repo marked deprecated in [repo-catalog](../../atlas/repo-catalog.md)
2. Edges removed/updated in [dependency-map](../../atlas/dependency-map.md)
3. `atlas/repos/<repo>.md` moved to `atlas/repos/_archived/<repo>.md`
4. Archived page keeps the same basename so repo-name link text stays stable
5. Inbound Markdown links updated if they should now point to a replacement repo instead
6. Entry logged in `log.md`
7. This staging file stays as audit trail
