# staging/new-repos/

Staging entry for a repo being onboarded into the atlas. Use `_template.md`.

Naming: `YYYY-MM-DD-<repo-name>.md`

## When to create an entry

**Trigger: first meaningful MR merged to master.** Do not create an entry for an empty or just-created repo — there is nothing worth documenting yet.

High-impact repos (ones other repos already depend on) qualify for same-day compilation. Everything else waits for the weekly pass.

The local `CLAUDE.md` in the repo may already exist before this entry is created. If so, the compilation step updates `Repo page: not yet compiled` to the real path.

## After the lead compiles it

1. `atlas/repos/<repo>.md` created from [[_example-service]]
2. Repo added to [[repo-catalog]]
3. Connections added to [[dependency-map]]
4. [[shared-libraries]], [[aws-resources]], [[ownership]] updated as needed
5. Entry logged in `log.md`
6. This staging file stays as audit trail

**Developer action after compilation:** update local `CLAUDE.md` — change `Repo page: not yet compiled` to `atlas/repos/<repo-name>.md`.
