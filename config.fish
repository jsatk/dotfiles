# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via fish_config command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/
# See: http://fishshell.com/docs/current/tutorial.html#tut_startup

# Default browser
set BROWSER open safari

# NOTE: There is probably a sexier nicer way to do this, but until I figure that out I am manually unsetting here.
# Unsets PATH
set -gx PATH

# Using rbenv for ruby. See: https://github.com/sstephenson/rbenv
# Enable shims and autocompletion for rbenv.
set -gx PATH $PATH $HOME/.rbenv/shims

# This allows us to use Homebrew versions of things (like git) rather than the pre-installed or XCode installed versions.
# See http://blog.grayghostvisuals.com/git/how-to-keep-git-updated/ for reference.
set -gx PATH $PATH /usr/local/bin

# Sets necessary PATH defaults
set -gx PATH $PATH /usr/bin /bin /usr/sbin /sbin

# Adds custom scripts to path.
set -gx PATH $PATH $HOME/Library/Scripts/*