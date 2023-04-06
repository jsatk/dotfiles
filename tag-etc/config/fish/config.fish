# Environment Variables {{{

set --global --export BROWSER open /Applications/Safari.app
set --export EDITOR nvim
set --export DEVELOPER $HOME/Developer
set --export GOPATH $HOME/go
set --export GPG_TTY (tty) # Required for gpg... sometimes... gpg is fickle and frustrating.
set --export BAT_THEME "TwoDark" # For Bat.  See: https://github.com/sharkdp/bat
set --local BREW_PREFIX (/opt/homebrew/bin/brew --prefix)
set --export JAVA_HOME (/usr/libexec/java_home -v 1.8.0_362)

# }}}
# Files I need to source {{{

[ -f $BREW_PREFIX/share/autojump/autojump.fish ]
and source $BREW_PREFIX/share/autojump/autojump.fish

[ -f {$HOME}/.iterm2_shell_integration.fish ]
and source {$HOME}/.iterm2_shell_integration.fish

[ -f $BREW_PREFIX/opt/asdf/asdf.fish ]
and source /opt/homebrew/opt/asdf/libexec/asdf.fish

# }}}
# Path {{{

set PATH \
  $HOME/.yarn/bin \
  $HOME/.asdf/installs/rust/stable/bin \
  $HOME/.asdf/shims \
  $BREW_PREFIX/bin \
  $BREW_PREFIX/sbin \
  /usr/local/bin \
  /usr/bin \
  /bin \
  /usr/sbin \
  /sbin \
  $HOME/.config/scripts \
  /Library/TeX/texbin \
  $HOME/Library/Application\ Support/Coursier/bin \
  $GOPATH/bin \

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into git.

[ -f $HOME/.config/fish/extras.fish ]
and source $HOME/.config/fish/extras.fish

# }}}

# vim: foldmethod=marker:foldmarker={{{,}}}
