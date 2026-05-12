# Environment Variables {{{1

set --export EDITOR nvim
set --export AWS_PROFILE hr-experiences-eng-gusto-main

# Files I need to source {{{1

# For Gusto.
source ~/.gusto/init.fish

# See: https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# Default fish settings for interactive sessions {{{1
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# vim: foldmethod=marker foldlevel=0
