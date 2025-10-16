.DEFAULT_GOAL := all

# Configuration Variables ------------------------------------------------- {{{1

# Gloabl Binaries
global_node_modules := \
	@mermaid-js/mermaid-cli \
	neovim \
	ts-node \
	typescript \
	typescript-language-server

# Stow packages
stow_packages := \
	bat \
	curl \
	fish \
	git \
	homebrew \
	security \
	tmux \
	vim \
	weechat \
	wezterm

# Core Targets ------------------------------------------------------------ {{{1

.PHONY: all
all: | update clean ## Run everything.  Default target.
	@echo "✅ All done!"

.PHONY: update
update: | install ## Update everything.
	brew bundle --global --quiet
	npm update --silent --global

.PHONY: install
install: | stow breww node_modules ## Install everything.  (Does not update anything.)

.PHONY: clean
clean: ## Remove all unnecessary files our package managers don't need.
	brew bundle --global cleanup --force
	brew cleanup

# Homebrew ---------------------------------------------------------------- {{{1

brew_status := $(shell brew bundle check --global --no-upgrade > /dev/null && echo 0 || echo 1)

.PHONY: breww # Using `breww` rather than `brew` to avoid namespace collisions with `brew` command.
breww: ## Check if Homebrew is installed and run `brew bundle` if it is.
	@echo "Checking if Homebrew is installed..."

ifeq ($(brew_status), 0)
	@echo "✅ Homebrew is installed.  Proceeding with with 'brew bundle'."
	brew bundle --global --quiet --no-upgrade
else
	$(error ❌ Homebrew is not installed.  Please install following the instructions at https://brew.sh/ and re-run this Makefile.)
endif

# Node -------------------------------------------------------------------- {{{1

.PHONY: node_modules
node_modules: ## Install global node modules.
	npm install --silent --global $(global_node_modules) ## Install global node modules.

# Stow -------------------------------------------------------------------- {{{1

.PHONY: stow
stow: ## Set up dotfiles using GNU Stow.
	stow $(stow_packages)

# Help -------------------------------------------------------------------- {{{1

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Print this help text.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# vim: foldmethod=marker textwidth=80 foldlevel=0
