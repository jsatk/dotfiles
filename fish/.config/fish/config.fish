# Environment Variables {{{1

set --export EDITOR nvim
set --export AWS_PROFILE hr-experiences-eng-gusto-main
set --export BRAINTRUST_API_KEY (security find-generic-password -a $USER -s BRAINTRUST_API_KEY -w 2>/dev/null)

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
