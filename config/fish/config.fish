#  ______     ______     __   __     ______   __     ______     ______   __     ______     __  __
# /\  ___\   /\  __ \   /\ "-.\ \   /\  ___\ /\ \   /\  ___\   /\  ___\ /\ \   /\  ___\   /\ \_\ \
# \ \ \____  \ \ \/\ \  \ \ \-.  \  \ \  __\ \ \ \  \ \ \__ \  \ \  __\ \ \ \  \ \___  \  \ \  __ \
#  \ \_____\  \ \_____\  \ \_\\"\_\  \ \_\    \ \_\  \ \_____\  \ \_\    \ \_\  \/\_____\  \ \_\ \_\
#   \/_____/   \/_____/   \/_/ \/_/   \/_/     \/_/   \/_____/   \/_/     \/_/   \/_____/   \/_/\/_/

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/config/fish/config.fish
# Twitter:    @jsatk

# }}}
# General {{{

# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via `fish_config` command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/
# See: http://fishshell.com/docs/current/tutorial.html#tut_startup

# $PATH is set via $fish_user_paths with `set -U` so it persists.
# See: https://fishshell.com/docs/current/tutorial.html#tut_universal

# Universal Defaults
set --export BROWSER open safari
set --export EDITOR vim
set --export DEVELOPER ~/Developer
# Required for gpg... sometimes... gpg is fickle and frustrating.
set --export GPG_TTY (tty)
# Required for n, a node version manager – alternative to nvm.
set --export N_PREFIX ~/n
# Config file for ripgrep.  See:
# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set --export RIPGREP_CONFIG_PATH ~/.ripgreprc

set PATH $N_PREFIX/bin ~/.rbenv/shims /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin /usr/local/MacGPG2/bin /Library/TeX/texbin ~/Library/scripts

# For Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Sets brew cask symlink to /Applications instead of ~/Applications
set --export HOMEBREW_CASK_OPTS '--appdir=/Applications'

# For my Powerline prompt
set --export powerline_symbols "$HOME/Dropbox (Personal)/dotfiles/fontpatcher/fonts/powerline-symbols.sfd"

# For rbenv ruby version manager
# This modifies your path and adds the `.rbenv` folder to it.
if test -f /usr/local/bin/rbenv
    status --is-interactive; and source (rbenv init -|psub)
end

# For Github Dashboard in Vim
source ~/.vim-ghd-token

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into github.

[ -f $HOME/.config/fish/extras.fish ]; and source $HOME/.config/fish/extras.fish

# }}}
