.DEFAULT_GOAL := all

# TODO: Install/manage pip plugins for both python2 & python3
#
# notmuch
# pynvim
# urlscan

# Configuration Variables -------------------------------------------------- {{{

# Gloabl Binaries
global_node_modules := \
	bash-language-server \
	diff-so-fancy \
	neovim \
	dockerfile-language-server-nodejs \
	speed-test \

global_gems := \
	neovim \
	tmuxinator \

# Paths to folders & binaries
# Brew
homebrew_root := /usr/local
cellar := $(homebrew_root)/Cellar
bin := $(homebrew_root)/bin
homebrew := $(bin)/brew

# asdf
# All `asdf_plugins` should all have a coresponding entry in ~/.tool-versions.
asdf_plugins := nodejs ruby rust sbcl sbt scala yarn
asdf_root := $(HOME)/.asdf
asdf_shims := $(asdf_root)/shims

# Node
yarn := $(asdf_shims)/yarn
node_modules_root := $(asdf_shims)
prefixed_node_modules := $(addprefix $(node_modules_root)/,$(global_node_modules))

# Ruby
gem := $(asdf_shims)/gem
gems_root := $(asdf_shims)
prefixed_gems := $(addprefix $(gems_root)/,$(global_gems))

# }}}
# Core Targets ------------------------------------------------------------- {{{

.PHONY: all
all: | update clean ## Run everything.  Default target.

.PHONY: update
update: | install ## Update everything.
	rcup -v
	brew bundle --global
	gem update $(global_gems)
	yarn global upgrade
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

$(asdf_plugins):
	-asdf plugin-add $@

.PHONY: asdf
asdf: | $(asdf_plugins) ## Install specific verions of languages -- language versions specified in ~/.tool-versions.
	asdf install

# }}}
# Node --------------------------------------------------------------------- {{{

# If we don't prefix the $prefixed_node_modules we get a warning from Make as
# the targets end up being the same because we install a package called "neovim"
# from both npm and gem.
node_modules_$(prefixed_node_modules):
	$(yarn) global add $(notdir $@)

.PHONY: node_modules
node_modules: | node_modules_$(prefixed_node_modules) ## Install global yarn modules.

# }}}
# Ruby --------------------------------------------------------------------- {{{

# If we don't prefix the $prefixed_gems we get a warning from Make as
# the targets end up being the same because we install a package called "neovim"
# from both npm and gem.
gems_$(prefixed_gems):
	$(gem) install $(notdir $@)

.PHONY: gems
gems: | gems_$(prefixed_gems) ## Install global gems.

# }}}
# Shellcheck --------------------------------------------------------------- {{{

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i -t \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./tag-scripts/test.sh

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
