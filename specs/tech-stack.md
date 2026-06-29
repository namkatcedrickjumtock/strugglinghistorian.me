# Tech Stack

## Core

| Layer | Decision | Reason |
|-------|----------|--------|
| Static site generator | Hugo v0.163+ (extended) | Fast, Go-native, no Node.js required at runtime, excellent content pipeline |
| Theme | PaperMod — forced dark mode (`defaultTheme = "dark"`) | Editorial dark mode, fast, well-maintained, good typography |
| Fonts | PaperMod default system font stack | No custom fonts — uses PaperMod's native CSS variables |
| Hosting | Vercel | Free, global CDN, deploys on every push to `main`, no billing lock on public repos |
| CI/CD | Vercel GitHub integration | No GitHub Actions — Vercel handles builds and previews automatically |
| Custom domain | `strugglinghistorian.me` | Registered on Namecheap; A + CNAME records point to Vercel edge nodes |
| Hugo binary location | `/usr/local/Cellar/hugo/0.163.3/bin/hugo` (macOS via Homebrew) | |

## Content & Diagrams

| Tool | Use case |
|------|---------|
| Markdown (CommonMark) | All post content |
| Mermaid | Flowcharts, sequence diagrams, timelines, architecture diagrams — rendered via Hugo render hook + CDN JS |
| GoAT | Simple ASCII-style diagrams — use ` ```goat ` fenced code blocks, Hugo renders natively as SVG with zero JS |
| Draw.io → SVG | Complex custom diagrams — design in Draw.io desktop, export as `.svg`, embed as a page resource image |
| Page Bundle images | Screenshots, photos, figures — store in the post's folder alongside `index.md`, reference with standard Markdown image syntax |

## Hugo module structure

| Directory | Role |
|-----------|------|
| `themes/PaperMod/` | Theme (git submodule — never edit directly) |
| `layouts/` | Theme overrides and custom templates |
| `layouts/partials/header.html` | Full nav override: compass icon, Posts/Talks menu, inline search, theme toggle at far right |
| `layouts/partials/footer.html` | Footer override — removes "Powered by Hugo & PaperMod" |
| `layouts/partials/home_info.html` | Two-column hero: bio text left, sketch.png right |
| `layouts/partials/extend_head.html` | OG/Twitter meta tags for homepage social preview (LinkedIn, Twitter) |
| `layouts/partials/extend_footer.html` | Injects Mermaid JS only on pages with diagrams; pre-fills search input from URL param |
| `layouts/_default/_markup/` | Render hooks (Mermaid code block hook lives here) |
| `static/images/` | Served verbatim — `sketch.png` (hero illustration + OG image) lives here |
| `assets/css/extended/custom.css` | All custom CSS (auto-included by PaperMod) |
| `content/posts/` | All blog posts as Page Bundles |
| `content/talks/` | Conference talks, one per slug |

## Theme override rule

Do not edit files inside `themes/PaperMod/`. Override by placing a file at the identical relative path under `layouts/`. The project directory always takes precedence over the theme directory.

## Hugo configuration

Single config file: `hugo.toml` at project root. Key settings:

```toml
baseURL      = "https://strugglinghistorian.me/"
theme        = "PaperMod"
defaultTheme = "dark"        # forced dark; user can toggle
buildDrafts  = false         # drafts never built in production
```

Syntax highlighting: Chroma, Dracula style, line numbers enabled, copy-to-clipboard button on.

## Social preview

`layouts/partials/extend_head.html` injects homepage-scoped OG + Twitter meta tags:
- `og:image` → `https://strugglinghistorian.me/images/sketch.png`
- `og:title` → site title from `hugo.toml`
- `og:description` → site description from `hugo.toml`

PaperMod's own OG template handles per-post/talk pages. The `extend_head.html` only fires on the homepage (`{{ if .IsHome }}`).

After deploying OG changes: force LinkedIn to re-scrape at `linkedin.com/post-inspector/`.
