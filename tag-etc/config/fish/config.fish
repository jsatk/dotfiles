# Environment Variables {{{

set --global --export BROWSER open /Applications/Safari.app
set --export EDITOR nvim
set --export DEVELOPER $HOME/Developer
set --export GOPATH $HOME/go
set --export GPG_TTY (tty) # Required for gpg... sometimes... gpg is fickle and frustrating.
set --export BAT_THEME "TwoDark" # For Bat.  See: https://github.com/sharkdp/bat
set --local BREW_PREFIX (/opt/homebrew/bin/brew --prefix)
set --export JAVA_HOME (/usr/libexec/java_home -v 17)

# fzf {{{

# Use git to search files when in a git repo, otherwise use fd.
set --export FZF_DEFAULT_COMMAND 'fd --type file --hidden --follow --exclude .git'
# If a command is really long press `?` to see the full command in a preview
# window.  And press <C-y> to copy a command to the clipboard rather than run it.
set --export FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
# Attempt to preview with bat or highlight or coderay or rougify before finally
# using cat.  Only preview 100 lines.
set --export FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {} 2> /dev/null | head -100'"
# Use the default command for <C-t>.
set --export FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
# Preview directories using tree.  Only preview 100 lines.
set --export FZF_ALT_C_OPTS "--preview 'tree -C {} | head -100'"

# }}}

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
