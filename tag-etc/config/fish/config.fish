# Environment Variables {{{

set --global --export BROWSER open /Applications/Safari.app
set --export EDITOR nvim
set --export DEVELOPER $HOME/Developer
set --export GOPATH $HOME/go
set --export GPG_TTY (tty) # Required for gpg... sometimes... gpg is fickle and frustrating.
set --export BAT_THEME TwoDark # For Bat.  See: https://github.com/sharkdp/bat
set --local BREW_PREFIX /opt/homebrew
set --export JAVA_HOME (/usr/libexec/java_home -v 1.8.0_352)

# }}}
# Path {{{

set PATH \
    $HOME/.asdf/shims \
    $BREW_PREFIX/bin \
    $BREW_PREFIX/sbin \
    /usr/local/bin \
    /usr/bin \
    /bin \
    /usr/sbin \
    /sbin \
    $GOPATH/bin \
    $HOME/.config/scripts

# }}}
# Files I need to source {{{

[ -f $BREW_PREFIX/share/autojump/autojump.fish ]
and source $BREW_PREFIX/share/autojump/autojump.fish

[ -f $HOME/.iterm2_shell_integration.fish ]
and source {$HOME}/.iterm2_shell_integration.fish

[ -f $BREW_PREFIX/opt/asdf/asdf.fish ]
and source $BREW_PREFIX/opt/asdf/libexec/asdf.fish

# The next line updates PATH for the Google Cloud SDK.
[ -f $HOME/google-cloud-sdk/path.fish.inc ]
and source {$HOME}/google-cloud-sdk/path.fish.inc

# }}}
# Extras {{{

# The extras file is for extra stuff that is generally work
# specific that I don't want to check into git.

[ -f $HOME/.config/fish/extras.fish ]
and source $HOME/.config/fish/extras.fish

# }}}

# vim: foldmethod=marker:foldmarker={{{,}}}
