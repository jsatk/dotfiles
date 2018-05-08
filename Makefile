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
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/Makefile
# Twitter:    @jsatk
# References: https://github.com/stephencelis/dotfiles/blob/master/Makefile

# }}}
# TODO {{{
#
# # Stuff to fix in Makefile
#
# * Install n
# * Install vim plug
# * Set fish shell as default
# * Install up contacts-cli
# * Make caps lock to escape
# * Set ruby to rbenv
# * Install fonts
# * Symlink ~/Library/scripts

$(info TODO: 📝)
$(info  )
$(info "1. Figure out how to install and/or update n.  We are currently doing this manually.")
$(info "2. Figure out how to install and/or update yarn.  We are currently doing this manually.")
$(info "3. Figure out how to properly install fonts.")
$(info "4. Figure out how to set fish as the default shell.")
$(info "5. Figure out how install pip packages.")
$(info "6. Figure out how setup path.")
$(info "7. Figure out how install npm, pip, and gems if they are not already installed.  (I.E.  What we're alredy doing with Homebrew).")
$(info  )

# }}}
# setup {{{

symlinks = \
	bash_profile \
	config \
	gitconfig \
	irbrc \
	irssi \
	jsatk.tmuxtheme \
	mbsyncrc \
	msmtprc \
	mutt \
	muttrc \
	notmuch-config \
	powerline-shell \
	terminfo \
	tmux.conf \
	urlview \
	vim/custom-dictionary.utf-8.add \
	vimrc \

formulae = \
	autojump \
	bash \
	bash-completion \
	ctags \
	keith/formulae/contacts-cli \
	fish \
	git \
	gist \
	go \
	irssi \
	isync \
	jq \
	lynx \
	mas \
	mercurial \
	msmtp \
	mtr \
	mutt \
	node-build \
	notmuch \
	pinentry-mac \
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
	urlview \
	vim \
	wget \
	# yarn --without-node \ # Figure out how to handle flags

# }}}
# core targets {{{
default: | update clean

install: | brew ln node

update: | install
	brew update
	brew upgrade
	gem update
	npm update --global --quiet
	vim +PlugUpdate +quitall
	reattach-to-user-namespace mas upgrade

clean: | install
	brew cleanup
	gem clean
	vim +PlugClean +quitall

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
