# Roadmap

Prioritised phases. Each phase is independently shippable. Later phases depend on earlier ones only where noted.

---

## Phase 0 — Foundation ✅ (complete)

- [x] Hugo site scaffolded with PaperMod theme
- [x] Forced dark theme with user toggle (moon/sun icons at far right of nav)
- [x] Posts sorted newest-first on homepage
- [x] Draft/publish system via front matter
- [x] Mermaid diagram support (render hook + runtime JS)
- [x] Code syntax highlighting (Dracula, line numbers, copy button)
- [x] Cover images, in-post images via Page Bundles
- [x] Tags, categories, series taxonomy pages
- [x] Full-text search (PaperMod JSON index, inline in nav)
- [x] RSS feed
- [x] Vercel CI/CD (auto-deploys on push to `main`) — replaced GitHub Pages/Actions
- [x] Custom domain `strugglinghistorian.me` via Namecheap DNS → Vercel
- [x] Makefile for post workflow (new, run, serve, publish, unpublish, list)
- [x] SDD constitution and skills
- [x] Custom nav: compass icon, Posts/Talks, inline search, theme toggle far right
- [x] Full-width hero: two-column layout with sketch.png illustration
- [x] Homepage Open Graph tags (sketch.png as social preview on LinkedIn/Twitter)
- [x] "Powered by Hugo & PaperMod" footer text removed
- [x] PaperMod default font stack (no custom fonts)

---

## Phase 1 — First real content

- [x] Landing page updated — dark editorial design, new hero copy
- [x] Talks section added — custom single layout, menu item
- [ ] Write and publish the first real post (not a demo)
- [ ] Add at least one talk to `content/talks/`
- [ ] Add a profile photo or favicon/site icon
- [ ] Confirm Mermaid diagrams render correctly in browser end-to-end

---

## Phase 2 — Content consistency

- [ ] Publish at least 5 posts across 2+ categories
- [ ] Add an `_index.md` to `content/posts/` with a section intro
- [ ] Review and settle on 10–15 core tags
- [ ] Add Open Graph images to individual posts (per-post cover images)

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
- Analytics — consider privacy-first alternative (Plausible, Umami) in Phase 4
- Newsletter — consider after 10+ posts are published
