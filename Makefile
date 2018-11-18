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
	gem clean
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
	# Currently `brew bundle check` without the `--verbose` flag appears to
	# be bugged, which is why I'm using the `--verbose` flag.  I filed an
	# issue.
	#
	# Also, I can't use Make's conditionals here because .SHELLSTATUS isn't
	# available in the version of make that comes preinstalled on macOS
	# (v3.81 as of 2018-11-17).  And we can't rely on a version of Make
	# installed with homebrew as this might be the first time we've ever run
	# homebrew.
	#
	# Computers are hard.
	#
	# References:
	# - https://github.com/Homebrew/homebrew-bundle/issues/401
	# - https://www.gnu.org/software/make/manual/make.html#Conditionals
	# - https://www.gnu.org/software/make/manual/html_node/Shell-Function.html
	#
	# Exits 1 if there are entries in our Brewfile that aren't installed.
	brew bundle check --verbose ; \
	# If last run command's status code does not equal 0...
	if [ $$? -ne 0 ] ; then \
		# Install not-yet-installed entries in Brewfile.
		brew bundle --no-upgrade ; \
	fi

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
