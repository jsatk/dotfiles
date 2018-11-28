.DEFAULT_GOAL := all

# Configuration Variables -------------------------------------------------- {{{

# Versions
ruby_version := 2.5.3
node_version := 8.12.0

# Gloabl Binaries
global_node_modules := \
	diff-so-fancy \
	glow \
	speed-test \
	vtop \

global_gems = \
	tmuxinator \
	bundler \

# Paths to folders & binaries
# Brew
homebrew_root = /usr/local
cellar := $(homebrew_root)/Cellar
bin := $(homebrew_root)/bin
homebrew := $(bin)/brew

# Node
n_root := $(HOME)/.n
node := $(n_root)/n/versions/node/$(node_version)
node_modules_root = $(n_root)/lib/node_modules
prefixed_node_modules = $(addprefix $(node_modules_root)/,$(global_node_modules))

# Ruby
rbenv_root := $(HOME)/.rbenv
ruby := $(rbenv_root)/versions/$(ruby_version)
ruby_bin = $(ruby)/bin
gem := $(ruby_bin)/gem
prefixed_gems = $(addprefix $(ruby_bin)/,$(global_gems))

# }}}
# Core Targets ------------------------------------------------------------- {{{

.PHONY: all
all: | update clean ## Runs everything.  Default target.

.PHONY: update
update: | install ## Updates everything.  Does not install new stuff.
	rcup
	brew bundle --global
	gem update
	npm update --global
	vim +PackUpdate +quitall

.PHONY: install
install: | brew node ruby ## Installs everything.  Does not update anything.

.PHONY: clean
clean: ## Removes all unnecessary files our package managers don't need.
	brew bundle --global cleanup --force
	brew cleanup
	gem clean
	vim +PackClean +quitall

# }}}
# Homebrew ----------------------------------------------------------------- {{{

status := $(shell brew bundle check --no-upgrade > /dev/null && echo 0 || echo 1)

$(homebrew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

.PHONY: brew
brew: | $(homebrew) ## Installs Homebrew & Brewfile's formulae, casks, & apps.
ifeq ($(status), 1)
	brew bundle --no-upgrade
endif

# }}}
# Node --------------------------------------------------------------------- {{{

$(node):
	n $(node_version)
$(prefixed_node_modules):
	npm install --global $(notdir $@)

.PHONY: node
node: | $(node) $(prefixed_node_modules) ## Install node & global npm modules.

# }}}
# Ruby --------------------------------------------------------------------- {{{

$(ruby): | $(cellar)/rbenv $(cellar)/ruby-build
	rbenv install $(ruby_version)

$(prefixed_gems):
	$(gem) install $(notdir $@)

.PHONY: ruby
ruby: | $(ruby) $(prefixed_gems) ## Install ruby, rbenv, & global gems.

# }}}
# Help --------------------------------------------------------------------- {{{

.PHONY: help
help: ## Prints this help text.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# }}}
# vim: textwidth=80 noexpandtab shiftwidth=8 foldmethod=marker foldmarker={{{,}}}
