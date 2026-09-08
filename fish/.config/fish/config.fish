# Environment Variables {{{1

set --export EDITOR nvim
set --export AWS_PROFILE hr-experiences-eng-gusto-main
set --export BRAINTRUST_API_KEY (security find-generic-password -a $USER -s BRAINTRUST_API_KEY -w 2>/dev/null)

# Gusto sets a role-level org default of claude-sonnet-5, and Claude Code
# periodically clears the `model` pin from ~/.claude/settings.json, so new
# sessions land on Sonnet. ANTHROPIC_MODEL outranks both. Keep it here, not
# in settings.json's env block: `scope doctor` clean-settings deletes it there.
set --export ANTHROPIC_MODEL 'opus[1m]'

# -g, not fish_add_path's default -U: keeps this out of fish_variables, which we
# no longer track. Matches fish 4.3+ moving user-facing config out of universal
# scope.
fish_add_path -g /opt/homebrew/opt/openjdk/bin ~/bin

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
