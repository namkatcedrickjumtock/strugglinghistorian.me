# Skill: Deployment

## Normal publish flow

```bash
make publish POST=<slug>
# → sets draft = false
# → git commit -m "publish: <slug>"
# → git push origin main
# → GitHub Actions builds and deploys (~30 seconds)
```

## Normal unpublish flow

```bash
make unpublish POST=<slug>
# → sets draft = true
# → git commit -m "unpublish: <slug>"
# → git push origin main
# → GitHub Actions redeploys without the post
```

## Site changes (not posts)

For config, layout, or template changes:

```bash
# 1. Test locally
make serve

# 2. Verify the change looks right at http://localhost:1313

# 3. Commit and push
git add -A
git commit -m "describe: what changed and why"
git push origin main
```

## Checking deploy status

Watch the Actions tab at:
`https://github.com/namkatcedrickjumtock/strugglinghistorian.me/actions`

A green tick means the deploy succeeded. A red X means something failed — check the logs.

## If a deploy fails

Common causes:

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| `hugo: command not found` | Hugo version mismatch in workflow | Update `HUGO_VERSION` in `deploy.yml` |
| Build error in logs | Invalid front matter or template syntax | Run `make build` locally to reproduce |
| 404 after deploy | `baseURL` mismatch | Check `hugo.toml` baseURL matches domain |
| Old content still showing | `--gc` not in build command | Already present in `deploy.yml` — verify it wasn't removed |

## Local production build (pre-deploy check)

```bash
make build
# Clears public/, runs hugo --gc --minify
# Inspect public/ to verify output before pushing
```

## Adding a new theme (safe swap)

1. Add new theme as submodule: `git submodule add <url> themes/<name>`
2. Change `theme = "<name>"` in `hugo.toml`
3. Run `make serve` to preview
4. If it works, commit: `git add -A && git commit -m "theme: switch to <name>"`
5. To revert: change `theme` back to `PaperMod` in `hugo.toml`, commit, push

PaperMod submodule is always kept — reverting is one line in `hugo.toml`.
