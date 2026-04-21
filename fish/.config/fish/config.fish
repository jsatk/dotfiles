# Environment Variables {{{1

set --export EDITOR nvim

# Files I need to source {{{1

zoxide init fish | source

# Default fish settings for interactive sessions {{{1
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# vim: foldmethod=marker foldlevel=0
