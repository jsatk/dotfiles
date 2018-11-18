$(info "📝 TODOs & Notes")
$(info)
$(info "1. Update `brew bundle` to be less noisey.  Maybe a combination of")
$(info "   `brew bundle check --no-upgrade` & Make's conditional?")
$(info "	- https://www.gnu.org/software/make/manual/make.html#Conditionals")
$(info)

# Core Targets ------------------------------------------------------------- {{{

default: | update clean

update: | install
	rcup
	brew bundle --global
	gem update
	npm update --global
	vim +PackUpdate +quitall

install: | brew node ruby

clean:
	brew bundle --global cleanup --force
	brew cleanup
	gem clean --silent
	vim +PackClean +quitall

# }}}
# Homebrew ----------------------------------------------------------------- {{{

homebrew_root = /usr/local
cellar := $(homebrew_root)/Cellar
bin := $(homebrew_root)/bin
lib := $(homebrew_root)/lib
homebrew := $(bin)/brew

$(homebrew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew: | $(homebrew)
	# Install any not installed formulas, casks, & apps, but don't upgrade.
	brew bundle --global --no-upgrade

# }}}
# Node --------------------------------------------------------------------- {{{

global_node_modules = \
	diff-so-fancy \
	glow \
	speed-test \
	vtop \

node_version := 8.12.0
n_root := $(HOME)/.n
node := $(n_root)/n/versions/node/$(node_version)
node_modules_root = $(lib)/node_modules
prefixed_node_modules = $(addprefix $(node_modules_root)/,$(global_node_modules))

$(node):
	n $(node_version)
$(prefixed_node_modules):
	npm install --global $(notdir $@)

node: | $(node) $(prefixed_node_modules)

# }}}
# Ruby --------------------------------------------------------------------- {{{

global_gems = \
	tmuxinator \
	bundler \

ruby_version := 2.5.3
rbenv_root := $(HOME)/.rbenv
ruby := $(rbenv_root)/versions/$(ruby_version)
ruby_bin = $(ruby)/bin
gem := $(ruby_bin)/gem
prefixed_gems = $(addprefix $(ruby_bin)/,$(global_gems))

$(ruby): | $(cellar)/rbenv $(cellar)/ruby-build
	rbenv install $(ruby_version)

$(prefixed_gems):
	gem install $(notdir $@)

ruby: | $(ruby) $(prefixed_gems)

# }}}

.PHONY: update clean

# vim: textwidth=80 noexpandtab shiftwidth=8 foldmethod=marker foldmarker={{{,}}}
