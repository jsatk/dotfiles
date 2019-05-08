.DEFAULT_GOAL := all

# Configuration Variables -------------------------------------------------- {{{

# Gloabl Binaries
global_node_modules := \
	diff-so-fancy \
	glow \
	speed-test \

global_gems = \
	tmuxinator \

# Paths to folders & binaries
# Brew
homebrew_root = /usr/local
cellar := $(homebrew_root)/Cellar
bin := $(homebrew_root)/bin
homebrew := $(bin)/brew

# asdf
asdf_root := $(HOME)/.asdf
asdf_shims := $(asdf_root)/shims

# Node
npm := $(asdf_shims)/npm
node_modules_root = $(asdf_shims)
prefixed_node_modules = $(addprefix $(node_modules_root)/,$(global_node_modules))

# Ruby
gem := $(asdf_shims)/gem
gems_root = $(asdf_shims)
prefixed_gems = $(addprefix $(gems_root)/,$(global_gems))

# }}}
# Core Targets ------------------------------------------------------------- {{{

.PHONY: all
all: | update clean ## Run everything.  Default target.

.PHONY: update
update: | install ## Update everything.
	rcup
	brew bundle --global
	gem update $(global_gems)
	npm update --global
	vim +PackUpdate +quitall

.PHONY: install
install: | brew asdf node_modules gems ## Install everything.  (Does not update anything.)

.PHONY: clean
clean: ## Remove all unnecessary files our package managers don't need.
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
brew: | $(homebrew) ## Install Homebrew & Brewfile's formulae, casks, & apps.
ifeq ($(status), 1)
	brew bundle --no-upgrade
endif

# }}}
# asdf --------------------------------------------------------------------- {{{

.PHONY: asdf
asdf: | ## Install specific verions of languages -- language versions specified in ~/.tool-versions.
	asdf install

# }}}
# Node --------------------------------------------------------------------- {{{

$(prefixed_node_modules):
	$(npm) install --global $(notdir $@)

.PHONY: node_modules
node_modules: | $(prefixed_node_modules) ## Install global npm modules.

# }}}
# Ruby --------------------------------------------------------------------- {{{

$(prefixed_gems):
	$(gem) install $(notdir $@)

.PHONY: gems
gems: | $(prefixed_gems) ## Install global gems.

# }}}
# Help --------------------------------------------------------------------- {{{

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Print this help text.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# }}}
# vim: textwidth=80:noexpandtab:shiftwidth=8
# vim: foldmethod=marker:foldmarker={{{,}}}
