# ~/.config/fish/config.fish

# Preamble {{{

# Author:  Jesse Atkinson
# Email:   jesse@jsatk.us
# Source:  https://github.com/jsatk/dotfiles/blob/master/config/fish/config.fish
# Twitter: @jsatk

# }}}
# General {{{

# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via `fish_config` command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/
# See: http://fishshell.com/docs/current/tutorial.html#tut_startup

# Universal Defaults
set --export BROWSER open safari
set --export EDITOR vim
set --export DEVELOPER ~/Developer
# Required for gpg... sometimes... gpg is fickle and frustrating.
set --export GPG_TTY (tty)
# Config file for ripgrep.  See:
# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set --export RIPGREP_CONFIG_PATH ~/.ripgreprc
# For Bat.  See: https://github.com/sharkdp/bat
set --export BAT_THEME "Monokai Extended Light"

set PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin
set PATH $PATH /usr/local/MacGPG2/bin /Library/TeX/texbin $HOME/Library/scripts
set PATH $PATH $HOME/go/bin

# For golang
set -x -U GOPATH $HOME/go

# For Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Sets brew cask symlink to /Applications instead of ~/Applications
set --export HOMEBREW_CASK_OPTS '--appdir=/Applications'

# For my Powerline prompt
set --export powerline_symbols "$HOME/Dropbox (Personal)/dotfiles/fontpatcher/fonts/powerline-symbols.sfd"

# For asdf – a version manager for all languages (no more nvm, rbenv, rvm, etc.)
# https://github.com/asdf-vm/asdf
[ -f /usr/local/opt/asdf/asdf.fish ]; and source /usr/local/opt/asdf/asdf.fish

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into github.

[ -f $HOME/.config/fish/extras.fish ]; and source $HOME/.config/fish/extras.fish

# }}}
