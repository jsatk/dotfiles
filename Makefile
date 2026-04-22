.DEFAULT_GOAL := all

# Configuration Variables ------------------------------------------------- {{{1

# Global Binaries
global_node_modules := \
	@mermaid-js/mermaid-cli \
	neovim \
	typescript \
	typescript-language-server

# Stow packages
# NOTE: I'm intentionally not including `mail` as I no longer actively use mutt
# for my email, but I don't want to delete the configuration just in case I want
# to use it again in the future.
stow_packages := \
	bat \
	curl \
	fish \
	git \
	homebrew \
	lisp \
	mise \
	security \
	tmux \
	vim \
	weechat \
	wezterm

global_gems := \
	neovim \
	rubocop \
	ruby-lsp \
	tmuxinator

# Core Targets ------------------------------------------------------------ {{{1

.PHONY: all
all: | update gems clean ## Run everything.  Default target.
	@echo "✅ All done!\n"

.PHONY: update
update: | install ## Update everything.
	@echo "💭 Upgrading brew formulas and global node modules...\n"
	brew bundle --global --quiet
	npm update --silent --global
	@echo "✅ Successfully upgraded brew formulas and node modules!\n"

.PHONY: install
install: | stow brew node_modules ## Install everything.  (Does not update anything.)

.PHONY: clean
clean: ## Remove all unnecessary files our package managers don't need.
	@echo "💭 Cleaning up after homebrew...\n"
	brew bundle --global cleanup --force
	brew cleanup
	@echo "✅ Successfully cleaned up homebrew!\n"
	@echo "💭 Cleaning up old gem versions...\n"
	gem cleanup
	@echo "✅ Successfully cleaned up gems!\n"
	@echo "💭 Cleaning up old mise runtime versions...\n"
	mise prune --yes
	@echo "✅ Successfully cleaned up mise runtimes!\n"

# Homebrew ---------------------------------------------------------------- {{{1

# Why `brew commands`?  It's an innocuous command that will fail if brew isn't
# installed.  We can't simply run `brew` as that returns a status code of 1.
brew_status := $(shell brew commands > /dev/null && echo 0 || echo 1)

.PHONY: brew
brew: ## Check if Homebrew is installed and run `brew bundle` if it is.
	@echo "💭 Checking if Homebrew is installed...\n"

ifeq ($(brew_status), 0)
	@echo "✅ Homebrew is installed.  Proceeding with with 'brew bundle'...\n"
	brew bundle --global --quiet --no-upgrade
	@echo "✅ Homebrew formulas & casks in '.Brewfile' successfully installed.\n"
else
	$(error ❌ Homebrew is not installed.  Please install following the instructions at https://brew.sh/ and re-run this Makefile.)
endif

# Node -------------------------------------------------------------------- {{{1

.PHONY: node_modules
node_modules: ## Install global node modules.
	@echo "💭 Installing global node modules...\n"
	npm install --silent --global $(global_node_modules)
	@echo "✅ Global node modules successfully installed.\n"

# Ruby -------------------------------------------------------------------- {{{1

.PHONY: gems
gems: ## Install global gems.
	@echo "💭 Installing global gems...\n"
	gem install --quiet $(global_gems)
	@echo "✅ Global gems successfully installed.\n"

# Stow -------------------------------------------------------------------- {{{1

.PHONY: stow
stow: ## Set up dotfiles using GNU Stow.
	@echo "💭 Symlinking dotfiles using 'stow'...\n"
	stow $(stow_packages)
	@echo "✅ Symlinking successful.\n"

# Help -------------------------------------------------------------------- {{{1

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Print this help text.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# vim: foldmethod=marker textwidth=80 foldlevel=0
