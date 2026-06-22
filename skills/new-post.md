# Skill: Creating a New Post

## When to use

Load this skill when Cedrick says "I want to write a post about X" or "new post" or "write a blog post".

## Step 1 — Interview (3 questions max)

Ask these before creating anything:

1. **What's the specific angle?** (Not just "colonial Africa" — what argument or question is this post making?)
2. **What will the post need?** (Mermaid diagrams? Code examples? Screenshots? A cover image? A timeline?)
3. **What category does it belong to?** (`essays`, `history`, `digital-humanities`, or `methodology`)

## Step 2 — Create the post bundle

```bash
make new POST=<slug>
```

Slug rules: lowercase, hyphens, no dates. E.g. `resistance-and-language` not `2026-06-22-post-about-resistance`.

## Step 3 — Fill the front matter

Open `content/posts/<slug>/index.md` and complete:

```toml
+++
title       = "Full title — Subtitle if relevant"
date        = 2026-06-22T10:00:00+00:00   # set to today's date
draft       = true                          # always starts as draft
description = "One sentence. Shown in listings and social previews."
tags        = ["specific-tag", "another-tag"]
categories  = ["history"]
series      = []
showToc     = true

[cover]
  image   = "cover.jpg"
  alt     = "Describe what the image shows"
  caption = "Source or contextual caption"
+++
```

## Step 4 — Structure before prose

Write the H2 section headings first. A well-structured post has 4–7 major sections. Confirm the structure with Cedrick before writing body text.

Typical structure for a history post:
- **Opening image / hook** — the specific scene or moment that opens the question
- **Context / background** — what the reader needs to know
- **The argument** — the core claim or finding, 2–3 sections
- **Evidence / examples** — specific cases, data, documents
- **Diagram section** (if applicable) — a Mermaid or GoAT diagram
- **Counter-argument or complication** — what this analysis misses or gets wrong
- **Conclusion** — what's left open, not a summary of what was said

## Step 5 — Add diagrams where useful

Use Mermaid for:
- Timelines (`timeline` type)
- Administrative hierarchies or power flows (`graph TD`)
- Process flows (`flowchart LR`)
- Comparative relationships (`flowchart`)

Use GoAT for very simple structural diagrams (boxes, arrows) where Mermaid is overkill.

Use Draw.io SVG export for complex custom maps or architecture diagrams.

## Step 6 — Add images

Place images in the post folder:
```
content/posts/<slug>/
├── index.md
├── cover.jpg
└── figure-1.png
```

Reference in the post body:
```markdown
![Alt text describing what the image shows](figure-1.png)
```

For screenshots: same process. Name descriptively (`census-ledger-1921.png` not `screenshot.png`).

## Step 7 — Preview

```bash
make serve
```

Navigate to `http://localhost:1313/posts/<slug>/` and check:
- [ ] Front matter renders correctly (title, date, description, tags)
- [ ] Cover image loads
- [ ] Table of contents is correct
- [ ] Mermaid diagrams render (not raw code)
- [ ] Code blocks have syntax highlighting
- [ ] Images load with correct alt text

## Step 8 — Publish

When ready:
```bash
make publish POST=<slug>
```

This sets `draft = false`, commits with message `publish: <slug>`, and pushes. GitHub Actions deploys in ~30 seconds.
