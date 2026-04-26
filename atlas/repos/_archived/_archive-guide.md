# Archived repo pages

Deprecated repo pages move into this folder.

## Rules

- Keep the archived filename exactly equal to the repo name: `atlas/repos/_archived/<repo-name>.md`.
- Add an archive warning at the top of the page with the deprecation date, reason, and successor if one exists.
- Remove the repo from active dependency and ownership listings, then add it to the deprecated or archived section of [[repo-catalog]].
- Leave useful gotchas and context in place unless they are misleading after deprecation.

## Why the basename matters

Obsidian wikilinks resolve by basename. Keeping the filename as `<repo-name>.md` means existing repo-name wikilinks can still resolve after the page is archived.

## Related docs

- [[repo-catalog]]
- [[maintaining-the-atlas]]
