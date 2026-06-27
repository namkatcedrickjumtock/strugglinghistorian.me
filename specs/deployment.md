# Deployment

## How it works

```
Push to main
    → Vercel detects the push (GitHub integration)
    → Hugo builds with --gc --minify  (vercel.json + HUGO_VERSION env var)
    → Site live at https://strugglinghistorian.me within ~30s
```

Draft posts (`draft = true`) are **never included** in production builds. They are safe to commit and push.

## Vercel configuration

File: `vercel.json` (project root)

```json
{
  "buildCommand": "hugo --gc --minify",
  "outputDirectory": "public",
  "framework": "hugo"
}
```

- **Hugo version**: set via Vercel env variable `HUGO_VERSION = 0.163.0` (Production + Preview + Development)
- **Trigger**: every push to `main` auto-deploys to production
- **Preview deploys**: every PR/branch gets a unique preview URL automatically

The `--gc` flag removes orphaned cached files — critical because Hugo does not clear `public/` between builds.

## Custom domain

- Domain: `strugglinghistorian.me` (purchased on Namecheap)
- Registered in Vercel project: `strugglinghistorian-me`
- DNS on Namecheap Advanced DNS:
  ```
  A     @    216.198.79.1       (Vercel edge node 1)
  A     @    64.29.17.1         (Vercel edge node 2)
  CNAME www  44e4bcff869faddc.vercel-dns-017.com
  ```
- SSL: auto-provisioned by Vercel, auto-renewed

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
