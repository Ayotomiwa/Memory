# staging/confluence/

Confluence content, imported verbatim.

## What goes here

- Pages exported from Confluence (markdown or HTML-to-markdown)
- Copy-pasted Confluence content with the source URL at the top
- Screenshots or diagrams referenced by those pages (place alongside the markdown file)

## Expected header

Every file should start with:

```
---
source: Confluence
source_url: <confluence URL>
imported: YYYY-MM-DD
imported_by: <name>
original_updated: <last-updated date from Confluence, if known>
---
```

## Compile target

Confluence pages usually compile into one of:

- a `atlas/standards/*.md` page for conventions
- a `atlas/flows/*.md` page for cross-service descriptions
- a `atlas/repos/*.md` page for repo-specific docs
- the relevant `atlas/standards/*.md` page for reusable technical guidance
- a `atlas/decisions/*.md` page for decisions

## Ingest workflow

1. Import the page into this folder with the header above.
2. Identify durable content and outdated content.
3. Compile durable content into the right atlas page(s), adding Markdown links.
4. If the Confluence page contradicts existing atlas content, flag a contradiction callout on the atlas page.
5. Log the ingest in `log.md`.
6. Leave the Confluence file here as the evidence trail.
