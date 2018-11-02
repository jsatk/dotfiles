# ~/.config/fish/config.fish

# Preamble {{{

# Jesse Atkinson | jesse@jsatk.us | @jsatk

# Fish prompt can be modified via `fish_config` command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/

# }}}
# Path {{{

set PATH (brew --prefix)/bin (brew --prefix)/sbin /usr/bin /bin /usr/sbin /sbin
set PATH $PATH /usr/local/MacGPG2/bin /Library/TeX/texbin $HOME/Library/scripts
set PATH $PATH $HOME/go/bin

# }}}
# Environment Variables {{{

# Tmuxinator & many other tools need these set.
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
# For golang
set --export --universal GOPATH $HOME/go
# For my Powerline prompt
set --export powerline_symbols "$HOME/Dropbox (Personal)/dotfiles/fontpatcher/fonts/powerline-symbols.sfd"

# }}}
# Files I need to source {{{

# For Autojump
[ -f (brew --prefix)/share/autojump/autojump.fish ]
and source (brew --prefix)/share/autojump/autojump.fish

# For asdf – a version manager for all languages (no more nvm, rbenv, rvm, etc.)
[ -f (brew --prefix)/opt/asdf/asdf.fish ]
and source (brew --prefix)/opt/asdf/asdf.fish

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into github.

[ -f $HOME/.config/fish/extras.fish ]
and source $HOME/.config/fish/extras.fish

# }}}
# vim: foldmethod=marker foldmarker={{{,}}}
