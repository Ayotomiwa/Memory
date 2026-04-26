# staging/chat-discussions/

Important Slack / Teams / chat threads preserved in markdown.

Chat is a poor long-term knowledge base. If a discussion produced durable knowledge, paste it here.

## When to add a file here

- A decision was made or confirmed in chat
- Someone explained a non-obvious behavior that the team should preserve
- A troubleshooting thread solved a real problem
- An informal agreement was reached about a standard or pattern

## Minimum content

```
---
date: YYYY-MM-DD
platform: <Slack | Teams>
channel: <#channel-name>
participants: [list]
link: <permalink if available>
---

# <topic>

## Summary
What the thread was about.

## Durable content
The parts worth keeping. Quote directly if it matters.

## Suggested atlas updates
Which pages this should flow into.
```

## Compile target

Compile into the durable layer that matches the content. Common atlas targets:

- `atlas/decisions/*.md`
- `atlas/repos/<repo>.md`
- `atlas/standards/*.md`
- `atlas/runbooks/*.md`
