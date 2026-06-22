# Deployment

## How it works

```
Push to main
    → GitHub Actions runs .github/workflows/deploy.yml
    → Hugo builds with --gc --minify
    → public/ uploaded to GitHub Pages
    → Site live at https://strugglinghistorian.me within ~30s
```

Draft posts (`draft = true`) are **never included** in production builds. They are safe to commit and push.

## GitHub Actions workflow

File: `.github/workflows/deploy.yml`

- **Trigger**: push to `main`, or manual `workflow_dispatch`
- **Hugo version**: 0.163.0 (extended)
- **Build command**: `hugo --gc --minify --baseURL "${{ steps.pages.outputs.base_url }}/"`
- **Output**: `public/` directory uploaded as a GitHub Pages artifact
- **Permission**: `pages: write`, `id-token: write`

The `--gc` flag removes orphaned cached files — critical because Hugo does not clear `public/` between builds. Without `--gc`, deleted posts remain on the live site.

## Custom domain

- `static/CNAME` contains `strugglinghistorian.me`
- Hugo copies this verbatim into `public/CNAME` on every build
- GitHub Pages reads `public/CNAME` and serves traffic for that domain
- DNS: point `A` records for `strugglinghistorian.me` to GitHub Pages IPs:
  ```
  185.199.108.153
  185.199.109.153
  185.199.110.153
  185.199.111.153
  ```
- And a `CNAME` record for `www` → `namkatcedrickjumtock.github.io`

## Makefile targets

| Target | Command | What it does |
|--------|---------|-------------|
| New post | `make new POST=<slug>` | Creates `content/posts/<slug>/index.md` as a draft |
| List posts | `make list` | Shows all posts with LIVE / DRAFT status |
| Publish | `make publish POST=<slug>` | Sets `draft = false`, commits, pushes → deploys |
| Unpublish | `make unpublish POST=<slug>` | Sets `draft = true`, commits, pushes |
| Dev server | `make serve` | `hugo server -D --navigateToChanged` (drafts visible) |
| Preview prod | `make preview` | `hugo server` (published only, mirrors production) |
| Build | `make build` | Clears `public/`, runs `hugo --gc --minify` |

## Hugo binary

Hugo is installed via Homebrew at `/usr/local/Cellar/hugo/0.163.3/bin/hugo`.

The Makefile auto-detects it:
```makefile
HUGO := $(shell which hugo 2>/dev/null || echo /usr/local/Cellar/hugo/0.163.3/bin/hugo)
```

If Hugo is in `$PATH` (after shell is initialised), `which hugo` resolves it. Otherwise the fallback path is used.

## Local development

```bash
make serve          # dev server with all drafts visible
make preview        # dev server, published posts only (mirrors prod)
make build          # full production build into public/
```

## GitHub repository setup (one-time)

1. Create repo `strugglinghistorian.me` on GitHub under `namkatcedrickjumtock`
2. `git remote add origin https://github.com/namkatcedrickjumtock/strugglinghistorian.me.git`
3. `git push -u origin main`
4. Repo Settings → Pages → Source: **GitHub Actions**
5. Set DNS records at your registrar (see Custom domain section above)
6. GitHub Pages → Custom domain: enter `strugglinghistorian.me` → Save → Enable HTTPS
