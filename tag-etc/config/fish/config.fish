# Environment Variables {{{

# Vi key bindings in Fish shell.
# See: https://fishshell.com/docs/current/index.html#editor
set --global fish_key_bindings fish_vi_key_bindings
# Tmuxinator & many other tools need these set.
set --global --export BROWSER open "/Applications/Google\ Chrome.app"
set --export EDITOR vim
set --export DEVELOPER ~/Developer
# Required for gpg... sometimes... gpg is fickle and frustrating.
set --export GPG_TTY (tty)
# Config file for ripgrep.
# See: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set --export RIPGREP_CONFIG_PATH ~/.ripgreprc
# For Bat.  See: https://github.com/sharkdp/bat
set --export BAT_THEME "TwoDark"
set --export JAVA_HOME (/usr/libexec/java_home -v 1.8)

set --local BREW_PREFIX (brew --prefix)

# fzf {{{

# Use git to search files when in a git repo, otherwise use fd.
set --export FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD | fd --type file --hidden --follow --exclude .git'
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
