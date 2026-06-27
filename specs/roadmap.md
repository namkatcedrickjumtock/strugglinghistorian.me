# Roadmap

Prioritised phases. Each phase is independently shippable. Later phases depend on earlier ones only where noted.

---

## Phase 0 — Foundation ✅ (complete)

- [x] Hugo site scaffolded with PaperMod theme
- [x] Dark/auto theme with user toggle
- [x] Posts sorted newest-first on homepage
- [x] Draft/publish system via front matter
- [x] Mermaid diagram support (render hook + runtime JS)
- [x] Code syntax highlighting (Dracula, line numbers, copy button)
- [x] Cover images, in-post images via Page Bundles
- [x] Tags, categories, series taxonomy pages
- [x] Full-text search (PaperMod JSON index)
- [x] RSS feed
- [x] GitHub Actions CI/CD to GitHub Pages
- [x] Custom domain CNAME
- [x] Makefile for post workflow (new, publish, unpublish, list)
- [x] SDD constitution and skills

---

## Phase 1 — First real content

- [x] Landing page updated — dark editorial design, new hero copy from me.md
- [x] Talks section added — custom single layout, homepage highlight, menu item
- [x] CLAUDE.md updated — Mode 5 (New Talk), Vercel deployment references
- [ ] Write and publish the first real post (not a demo)
- [ ] Add at least one talk to `content/talks/`
- [ ] Add a profile photo to the About page
- [ ] Add a favicon/site icon
- [ ] Confirm Mermaid diagrams render correctly in browser

---

## Phase 2 — Content consistency

- [ ] Publish at least 5 posts across 2+ categories
- [ ] Add an `_index.md` to `content/posts/` with a section intro
- [ ] Review and settle on 10–15 core tags
- [ ] Add Open Graph images to each post for social sharing

---

## Phase 3 — Discoverability

- [ ] Add structured data (JSON-LD for BlogPosting schema)
- [ ] Submit sitemap to Google Search Console
- [ ] Add `robots.txt` customisation if needed
- [ ] Add estimated reading time to post listings (already on by default via PaperMod)

---

## Phase 4 — Reader experience

- [ ] Comments system (options: giscus via GitHub Discussions, or skip entirely)
- [ ] Related posts section at the bottom of each post
- [ ] Series navigation (prev/next within a series)
- [ ] Print stylesheet or "reader mode" link

---

## Phase 5 — Content tooling

- [ ] Shortcode for Pull Quote (styled blockquote variant)
- [ ] Shortcode for Map embed (for posts with geographic content)
- [ ] Image gallery shortcode for posts with multiple photos
- [ ] `make stats` target — word count and post count summary

---

## Deferred / not planned

- Paid content or membership — not planned
- Comments via Disqus — too much tracking
- Analytics beyond GitHub Pages basic stats — consider privacy-first alternative (Plausible, Umami) in Phase 4
- Newsletter — consider after 10+ posts are published
