# staging/prompts/

Proposed reusable prompts before they are added to `claude-assets/prompts/`.

Naming: `YYYY-MM-DD-<prompt-name>.md`

## Process

1. Drop a proposal here using `_template.md`.
2. The weekly lint pass checks each proposal against existing prompts and skills.
3. The lead reviews the lint output and decides: approve, reject, or merge with an existing prompt or skill.
4. If approved, the lead creates `claude-assets/prompts/<name>.md` and adds an entry to `claude-assets/prompts-catalog.md`.
5. The staging file stays as audit trail.

Prompts are reusable asks. If the prompt needs procedural behavior, repo reads, or repeated decision logic, prefer a skill.
