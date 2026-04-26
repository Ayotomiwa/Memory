---
name: new-repo-compile
description: Compile a staging/new-repos entry into all required atlas pages and remind developer to update their local CLAUDE.md
user-invocable: true
---

Compile a new repo staging entry into the atlas.

If the user did not provide a staging file path, look in `staging/new-repos/` and ask which file to compile.

Steps:
1. Read the staging file. Do not modify it.
2. Create `atlas/repos/<repo-name>.md` from the working template `atlas/repos/_example-service.md`. Use `atlas/repos/_page-template.md` as the section checklist. Fill in every section from the staging file. Leave no placeholder fields unfilled — use `TBD` only if the staging file genuinely omits the information.
3. Update these atlas pages in place:
    - `atlas/repo-map/repo-catalog.md` — add new repo row
    - `atlas/repo-map/dependency-map.md` — add upstream and downstream connections
    - `atlas/repo-map/shared-libraries.md` — add to consumers table if the staging file lists shared libraries
    - `atlas/repo-map/aws-resources.md` — add AWS resources if listed
    - `atlas/repo-map/ownership.md` — add team ownership entry
4. Append an `ingest` entry to `log.md`: today's date, new repo name, bullet list of pages created or updated.
5. Output a one-line reminder for the developer: update `Repo page: atlas/repos/<repo-name>.md — not yet compiled` to `Repo page: atlas/repos/<repo-name>.md` in their local `CLAUDE.md`.

Report what you created or updated. If the staging file is missing required fields (owner, repo URL, connections), flag each gap rather than guessing.
