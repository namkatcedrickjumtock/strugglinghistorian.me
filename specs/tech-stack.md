# Tech Stack

## Core

| Layer | Decision | Reason |
|-------|----------|--------|
| Static site generator | Hugo v0.163+ (extended) | Fast, Go-native, no Node.js required at runtime, excellent content pipeline |
| Theme | PaperMod (forced dark) | Editorial dark mode, fast, well-maintained, good typography |
| Hosting | Vercel | Free, global CDN, deploys on every push to `main`, no billing lock on public repos |
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
| `layouts/_default/_markup/` | Render hooks (Mermaid code block hook lives here) |
| `layouts/partials/extend_footer.html` | Injects Mermaid JS only on pages with diagrams |
| `static/` | Verbatim file copy — CNAME, favicon, robots.txt |
| `assets/` | Hugo pipeline — processed CSS/JS/images |
| `content/posts/` | All blog posts as Page Bundles |

## Theme override rule

Do not edit files inside `themes/PaperMod/`. Override by placing a file at the identical relative path under `layouts/`. The project directory always takes precedence over the theme directory.

## Hugo configuration

Single config file: `hugo.toml` at project root. Key settings:

```toml
baseURL     = "https://strugglinghistorian.me/"
theme       = "PaperMod"
defaultTheme = "auto"        # follows OS; user can toggle
buildDrafts = false          # drafts never built in production
```

Syntax highlighting: Chroma, Dracula style, line numbers enabled, copy-to-clipboard button on.
