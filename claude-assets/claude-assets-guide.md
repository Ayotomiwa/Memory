# Claude assets - maintainer guide

Related: [[skills-catalog]], [[prompts-catalog]]

---

## Skills

Skills are executable. They live in `.claude/skills/<name>/SKILL.md` and are auto-loaded via `--add-dir`. Engineers invoke them as `/skill-name`.

**To propose a new skill:**
1. Drop a proposal in `staging/skills/` using `_template.md`.
2. The weekly lint pass classifies it (duplicate / overlap / contradiction / new) and outputs a recommendation.
3. Lead reviews and, if approved, creates `.claude/skills/<name>/SKILL.md` and adds a `skills-catalog.md` entry.

**Skills catalog entry format:**
```
### /<name>
- **Purpose**: one sentence
- **Source**: `.claude/skills/<name>/SKILL.md`
- **When to use**: trigger scenarios
```

If a skill covers the same ground as a prompt, prefer the skill - it runs in-session without copy-paste.

---

## Prompts

Prompts are plain text reusable asks. They live in `claude-assets/prompts/<name>.md`.

**To propose a new prompt:**
1. Drop a proposal in `staging/prompts/` using `_template.md`.
2. The weekly lint pass classifies it (duplicate / overlap / contradiction / new) and outputs a recommendation.
3. Lead reviews and, if approved, creates `claude-assets/prompts/<name>.md` and adds a `prompts-catalog.md` entry.

**Prompts catalog entry format:**
```
## <name>
- **Purpose**: one sentence
- **Source**: `claude-assets/prompts/<name>.md`
- **When to use**: trigger scenarios
```

If a prompt is used frequently enough to warrant automation, convert it to a skill.
