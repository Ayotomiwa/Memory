# staging/deprecations/

Staging entry for every repo being deprecated before atlas pages are updated. Use `_template.md`.

Naming: `YYYY-MM-DD-<repo-name>-deprecation.md`

Deprecations are high-impact and qualify for same-day compilation.

## After the lead compiles it

1. Repo marked deprecated in [[repo-catalog]]
2. Edges removed/updated in [[dependency-map]]
3. `atlas/repos/<repo>.md` moved to `atlas/repos/_archived/<repo>.md`
4. Archived page keeps the same basename so repo-name wikilinks still resolve
5. Inbound wikilinks updated if they should now point to a replacement repo instead
6. Entry logged in `log.md`
7. This staging file stays as audit trail
