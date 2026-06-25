HUGO := $(shell which hugo 2>/dev/null || echo /usr/local/Cellar/hugo/0.163.3/bin/hugo)
CONTENT_DIR := content/posts

.DEFAULT_GOAL := help


.PHONY: help
help:
	@echo ""
	@echo "  The Struggling Historian — site commands"
	@echo ""
	@echo "  make new      POST=my-post-title   Create a new draft post"
	@echo "  make publish  POST=my-post-title   Publish a post (draft=false) and push"
	@echo "  make unpublish POST=my-post-title  Unpublish a post (draft=true) and push"
	@echo "  make list                           List all posts and their status"
	@echo "  make run                            Dev server (drafts visible, network accessible)"
	@echo "  make serve                          Dev server (drafts visible)"
	@echo "  make preview                        Dev server (published only, like prod)"
	@echo "  make build                          Build site to public/"
	@echo ""


.PHONY: new
new:
ifndef POST
	$(error POST is required. Usage: make new POST=my-post-title)
endif
	@SLUG="$$(echo '$(POST)' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')"; \
	POST_DIR="$(CONTENT_DIR)/$$SLUG"; \
	POST_FILE="$$POST_DIR/index.md"; \
	mkdir -p "$$POST_DIR"; \
	$(HUGO) new content "$$POST_FILE" 2>/dev/null || true; \
	echo ""; \
	echo "  ✓ Created: $$POST_FILE"; \
	echo "  → Edit the file, then run: make publish POST=$$SLUG"; \
	echo ""


.PHONY: publish
publish:
ifndef POST
	$(error POST is required. Usage: make publish POST=my-post-title)
endif
	$(call require_post,$(POST))
	@FILE="$(call post_file,$(POST))"; \
	sed -i '' 's/^draft = true/draft = false/' "$$FILE"; \
	sed -i '' 's/^draft: true/draft: false/' "$$FILE"; \
	echo ""; \
	echo "  ✓ Published: $$FILE"; \
	git add "$$FILE"; \
	git commit -m "publish: $(POST)"; \
	git push origin main; \
	echo ""; \
	echo "  → Live in ~30s at https://strugglinghistorian.me/posts/$(POST)/"; \
	echo ""


.PHONY: unpublish
unpublish:
ifndef POST
	$(error POST is required. Usage: make unpublish POST=my-post-title)
endif
	$(call require_post,$(POST))
	@FILE="$(call post_file,$(POST))"; \
	sed -i '' 's/^draft = false/draft = true/' "$$FILE"; \
	sed -i '' 's/^draft: false/draft: true/' "$$FILE"; \
	echo ""; \
	echo "  ✓ Unpublished: $$FILE"; \
	git add "$$FILE"; \
	git commit -m "unpublish: $(POST)"; \
	git push origin main; \
	echo ""; \
	echo "  → Removed from site after next deploy"; \
	echo ""


.PHONY: list
list:
	@echo ""
	@echo "  STATUS   POST"
	@echo "  ──────   ────────────────────────────────────────────"
	@for f in $(CONTENT_DIR)/*/index.md $(CONTENT_DIR)/*.md; do \
		[ -f "$$f" ] || continue; \
		slug=$$(echo "$$f" | sed 's|$(CONTENT_DIR)/||' | sed 's|/index.md||' | sed 's|\.md||'); \
		if grep -q '^draft = true\|^draft: true' "$$f" 2>/dev/null; then \
			echo "  DRAFT    $$slug"; \
		else \
			echo "  LIVE     $$slug"; \
		fi; \
	done
	@echo ""


.PHONY: run
run:
	$(HUGO) server -D --navigateToChanged --bind 0.0.0.0

.PHONY: serve
serve:
	$(HUGO) server -D --navigateToChanged

.PHONY: preview
preview:
	$(HUGO) server --navigateToChanged


.PHONY: build
build:
	rm -rf public/
	$(HUGO) --gc --minify
	@echo ""
	@echo "  ✓ Built to public/"
	@echo ""


# Returns path to post's index.md (bundle or flat file)
define post_file
$(shell \
	if [ -f "$(CONTENT_DIR)/$(1)/index.md" ]; then \
		echo "$(CONTENT_DIR)/$(1)/index.md"; \
	elif [ -f "$(CONTENT_DIR)/$(1).md" ]; then \
		echo "$(CONTENT_DIR)/$(1).md"; \
	fi \
)
endef

# Errors if post file doesn't exist
define require_post
$(if $(call post_file,$(1)),,$(error Post "$(1)" not found in $(CONTENT_DIR)/. Run 'make list' to see all posts.))
endef
