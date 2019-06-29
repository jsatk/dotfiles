.DEFAULT_GOAL := all

# Configuration Variables -------------------------------------------------- {{{

# Gloabl Binaries
global_node_modules := \
	bash-language-server \
	diff-so-fancy \
	dockerfile-language-server-nodejs \
	glow \
	neovim \
	speed-test \

global_gems = \
	neovim \
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
	vim +PlugUpdate +quitall

.PHONY: install
install: | brew asdf node_modules gems ## Install everything.  (Does not update anything.)
	vim +PlugInstall +quitall

.PHONY: clean
clean: ## Remove all unnecessary files our package managers don't need.
	brew bundle --global cleanup --force
	brew cleanup
	gem clean
	vim +PlugClean +quitall

# }}}
# Homebrew ----------------------------------------------------------------- {{{

brew_status := $(shell brew bundle check --no-upgrade > /dev/null && echo 0 || echo 1)

$(homebrew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

.PHONY: brew
brew: | $(homebrew) ## Install Homebrew & Brewfile's formulae, casks, & apps.
ifeq ($(brew_status), 1)
	brew bundle --no-upgrade
endif

# }}}
# asdf --------------------------------------------------------------------- {{{

# TODO: This is horrible.  Do this in a loop and stash the rsults of `asdf
#       plugin-list` so you only have to call it once.
node_installed   := $(shell [[ "$(shell asdf plugin-list)" == *nodejs* ]] && echo 0 || echo 1)
ruby_installed   := $(shell [[ "$(shell asdf plugin-list)" == *ruby*   ]] && echo 0 || echo 1)
golang_installed := $(shell [[ "$(shell asdf plugin-list)" == *golang* ]] && echo 0 || echo 1)
rust_installed   := $(shell [[ "$(shell asdf plugin-list)" == *rust*   ]] && echo 0 || echo 1)
python_installed := $(shell [[ "$(shell asdf plugin-list)" == *python* ]] && echo 0 || echo 1)

.PHONY: asdf
asdf: | ## Install specific verions of languages -- language versions specified in ~/.tool-versions.
ifeq ($(node_installed), 1)
	asdf plugin-add nodejs
endif
ifeq ($(ruby_installed), 1)
	asdf plugin-add ruby
endif
ifeq ($(golang_installed), 1)
	asdf plugin-add golang
endif
ifeq ($(rust_installed), 1)
	asdf plugin-add rust
endif
ifeq ($(python_installed), 1)
	asdf plugin-add python
endif
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
