# Environment Variables {{{

# Vi key bindings in Fish shell.
# See: https://fishshell.com/docs/current/index.html#editor
set --global fish_key_bindings fish_vi_key_bindings
# Tmuxinator & many other tools need these set.
set --export BROWSER open safari
set --export EDITOR vim
set --export DEVELOPER ~/Developer
# Required for gpg... sometimes... gpg is fickle and frustrating.
set --export GPG_TTY (tty)
# Config file for ripgrep.
# See: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set --export RIPGREP_CONFIG_PATH ~/.ripgreprc
# For Bat.  See: https://github.com/sharkdp/bat
set --export BAT_THEME "TwoDark"
# For golang
set --export --universal GOPATH $HOME/go
# For asdf + python.
# See: https://github.com/pyenv/pyenv/wiki/Common-build-problems#build-failed-error-the-python-zlib-extension-was-not-compiled-missing-the-zlib
set --export --global CPPFLAGS "-I(brew --prefix zlib)/include" pyenv install -v 3.7.0
set --local BREW_PREFIX (brew --prefix)

# For fzf
# Try bat, then highlight, and finally cat for preview.
# And don't print more than 500 lines.
# This works in vim as well as command line.
# TODO: Apparently it's bad for to throw `--preview` in the default options.
# Figure out way to limit this to only commands where `--preview` actually works.
set --export FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {} 2> /dev/null | head -500'"
# Use git to search files when in a git repo, otherwise use fd.
set --export FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD | fd --type f'
# Ctrl+t is the default keyboard shortcut for fuzzy find in TextMate & Sublime
# Text and has propigated to various other editors and fzf has made it a
# shortcut to activate it.
set --export FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# }}}
# Path {{{

set PATH \
  $BREW_PREFIX/bin \
  $BREW_PREFIX/sbin \
  $HOME/go/bin \
  /usr/bin \
  /bin \
  /usr/sbin \
  /sbin \
  $HOME/Library/scripts \
  /Library/TeX/texbin \

# }}}
# Files I need to source {{{

[ -f $BREW_PREFIX/share/autojump/autojump.fish ]
and source $BREW_PREFIX/share/autojump/autojump.fish

[ -f {$HOME}/.iterm2_shell_integration.fish ]
and source {$HOME}/.iterm2_shell_integration.fish

[ -f $BREW_PREFIX/opt/asdf/asdf.fish ]
and source $BREW_PREFIX/opt/asdf/asdf.fish

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into github.

[ -f $HOME/.config/fish/extras.fish ]
and source $HOME/.config/fish/extras.fish

# }}}
# vim: foldmethod=marker:foldmarker={{{,}}}
