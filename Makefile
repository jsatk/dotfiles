$(info "📝 TODOs & Notes")
$(info)
$(info "1. Figure out how to configure node version for n.")
$(info "	- Maybe just do it in this Makefile with a variable?")
$(info "2. Figure out how to configure ruby version for rbenv.")
$(info "	- Maybe just do it in this Makefile with a variable?")
$(info "3. Update to allow for calling of `brew bundle` in update target")
$(info "   without having it called twice.")
$(info "	- Maybe use Make's conditional?")
$(info "	- https://www.gnu.org/software/make/manual/make.html#Conditionals")
$(info)

# Core Targets ------------------------------------------------------------- {{{

default: | update clean

update: | install
	rcup
	# brew bundle --global
	gem update --silent
	npm update --global --silent
	vim +PackUpdate +quitall

install: | brew node ruby

clean:
	brew bundle --global cleanup --force
	# Somewhat confusingly – `brew bundle cleanup` does not do everything
	# this command does.
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
	brew bundle --global

# }}}
# Node --------------------------------------------------------------------- {{{

global_node_modules = \
	diff-so-fancy \
	glow \
	speed-test \
	vtop \

node_version := 8.12.0
node := $(homebrew_root)/n/versions/node/$(node_version)
node_modules_root = $(lib)/node_modules
prefixed_node_modules = $(addprefix $(node_modules_root)/,$(global_node_modules))

$(node):
	n $(node_version)
$(prefixed_node_modules):
	npm install --global --silent $(notdir $@)

node: | $(node) $(prefixed_node_modules)

# }}}
# Ruby --------------------------------------------------------------------- {{{

ruby_version := 2.5.3
ruby := $(HOME)/.rbenv/versions/$(ruby_version)
gem := $(ruby)/bin/gem
bundler := $(ruby)/bin/bundle

$(ruby): | $(cellar)/rbenv $(cellar)/ruby-build
	rbenv install $(ruby_version)

$(bundler): | $(ruby)
	$(gem) install --silent bundler

$(tmuxinator): | $(ruby)
	$(gem) install --silent tmuxinator

ruby: | $(ruby) $(bundler) $(tmuxinator)

# }}}

.PHONY: update clean

# vim: textwidth=80 noexpandtab shiftwidth=8 foldmethod=marker foldmarker={{{,}}}
