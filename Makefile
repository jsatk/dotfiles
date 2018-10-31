# ~/Dropbox (Personal)/dotfiles/Makefile
# Not symlinked to ~

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/Makefile
# Twitter:    @jsatk

# }}}
# TODO {{{

$(info TODO: 📝)
$(info  )
$(info "1. Figure out how to install and/or update n.  We are currently doing this manually.")
$(info "2. Figure out how to install and/or update yarn.  We are currently doing this manually.")
$(info "3. Figure out how to properly install fonts.")
$(info "4. Figure out how to set fish as the default shell.")
$(info "5. Figure out how install pip packages.")
$(info "6. Figure out how install go packages.")
$(info "7. Figure out how setup path.")
$(info "8. Figure out how install npm, pip, and gems if they are not already installed.  (I.E.  What we're alredy doing with Homebrew).")
$(info "9. Map caps lock to escape.")
$(info "10. Install fonts.")
$(info "11. Set ruby to rbenv.")
$(info "12. Symlink `~/Library/scripts`.")
$(info "13. Install and use `rcm`.")
$(info  )

# }}}
# core targets {{{
default: | update clean

install: | node

update: | install
	rcup -v
	brew bundle install
	gem update
	yarn global upgrade --silent
	vim +PackUpdate +quitall

clean: | install
	brew bundle cleanup --force
	gem clean
	vim +PackClean +quitall

# }}}
# brew {{{

# homebrew_root = /usr/local
# cellar := $(homebrew_root)/Cellar
# taps := $(homebrew_root)/Library/Taps
# caskroom = /usr/local/Caskroom

# applications = /Applications

# prefixed_formulae := $(addprefix $(cellar)/,$(notdir $(formulae)))
# brew: | $(brew_cask) $(prefixed_formulae)

# homebrew := $(homebrew_root)/bin/brew
# $(homebrew):
# 	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew_cask := $(taps)/caskroom/homebrew-cask
# $(brew_cask): | $(homebrew)
# 	brew tap Caskroom/cask

# $(prefixed_formulae): | $(homebrew)
# 	brew install $(notdir $@)

# }}}
# ln {{{

# prefixed_symlinks := $(addprefix $(HOME)/.,$(symlinks))
# ln: | $(prefixed_symlinks)

# $(prefixed_symlinks):
# 	 @ln -Fsv "$(PWD)/$(patsubst .%,%,$(notdir $@))" "$@"

# }}}
# node {{{

node: | $(node)
	yarn global add --silent \
		diff-so-fancy@latest \
		glow@latest \
		speed-test@latest \
		vtop@latest
$(node): | n stable

# }}}
# make {{{

.PHONY: update clean

# }}}
