#  ______     ______     ______   __  __     ______
# /\  ___\   /\  ___\   /\__  _\ /\ \/\ \   /\  == \
# \ \___  \  \ \  __\   \/_/\ \/ \ \ \_\ \  \ \  _-/
#  \/\_____\  \ \_____\    \ \_\  \ \_____\  \ \_\
#   \/_____/   \/_____/     \/_/   \/_____/   \/_/
#  __    __     ______     __  __     ______     ______   __     __         ______
# /\ "-./  \   /\  __ \   /\ \/ /    /\  ___\   /\  ___\ /\ \   /\ \       /\  ___\
# \ \ \-./\ \  \ \  __ \  \ \  _"-.  \ \  __\   \ \  __\ \ \ \  \ \ \____  \ \  __\
#  \ \_\ \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_____\  \ \_\    \ \_\  \ \_____\  \ \_____\
#   \/_/  \/_/   \/_/\/_/   \/_/\/_/   \/_____/   \/_/     \/_/   \/_____/   \/_____/

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse.atkinson@me.com
# Source:     https://github.com/jsatk/dotfiles/blob/master/Makefile
# Twitter:    @jsatk
# References: https://github.com/stephencelis/dotfiles/blob/master/Makefile

# }}}
# TODO {{{

# * Figure out how to properly install fonts
# * Figure out how to set fish as the default shell
# * Figure out how to install a set list of default gems
# * Figure out how to set up proper tmux $TERM so it fucking supports italics

# }}}
# setup {{{

symlinks = \
	bash_profile \
	config \
	gitconfig \
	irbrc \
	jsatk.tmuxtheme \
	mbsyncrc \
	muttrc \
	tmux.conf \
	vim \
	vimrc \

formulae = \
	autojump \
	bash \
	bash-completion \
	contacts \
	fish \
	git \
	gist \
	go \
	htop-osx \
	jq \
	mas \
	mercurial \
	mtr \
	mutt \
	node-build \
	postgresql \
	rbenv \
	reattach-to-user-namespace \
	ripgrep \
	ruby-build \
	sbt \
	scala \
	screenfetch \
	spark \
	tldr \
	tmux \
	trash \
	vim \
	wget \

# }}}
# core targets {{{
default: | update clean

install: | brew ln node

update: | install
	brew update
	brew upgrade
	gem update
	npm update --global --quiet
	vim +VundleUpdate +quitall
	reattach-to-user-namespace mas upgrade

clean: | install
	brew cleanup
	gem clean
	vim +VundleClean +quitall

# }}}
# brew {{{

homebrew_root = /usr/local
cellar := $(homebrew_root)/Cellar
taps := $(homebrew_root)/Library/Taps
caskroom = /usr/local/Caskroom

applications = /Applications

prefixed_formulae := $(addprefix $(cellar)/,$(notdir $(formulae)))
brew: | $(brew_cask) $(prefixed_formulae)

homebrew := $(homebrew_root)/bin/brew
$(homebrew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew_cask := $(taps)/caskroom/homebrew-cask
$(brew_cask): | $(homebrew)
	brew tap Caskroom/cask

$(prefixed_formulae): | $(homebrew)
	brew install $(notdir $@)

# }}}
# ln {{{

prefixed_symlinks := $(addprefix $(HOME)/.,$(symlinks))
ln: | $(prefixed_symlinks)

$(prefixed_symlinks):
	 @ln -Fsv "$(PWD)/$(patsubst .%,%,$(notdir $@))" "$@"

# }}}
# node {{{

node: | $(node)
	npm install --global \
		npm@latest \
		n@latest \
		diff-so-fancy@latest

$(node): | brew install node

# }}}
# make {{{

.PHONY: update clean

# }}}
