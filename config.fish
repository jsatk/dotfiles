# Note: All git aliases and configs stored in ~/.gitconfig.

# ============
# Basics, etc…
# ============

# Default browser
set BROWSER open safari

# NOTE: There is probably a sexier nicer way to do this, but until I figure that out I am manually unsetting here.
# Unsets PATH
set -g -x PATH

# Using rbenv for ruby. See: https://github.com/sstephenson/rbenv
# Enable shims and autocompletion for rbenv.
set -g -x PATH $PATH $HOME/.rbenv/shims

# This allows us to use Homebrew versions of things (like git) rather than the pre-installed or XCode installed versions.
# See http://blog.grayghostvisuals.com/git/how-to-keep-git-updated/ for reference.
set -g -x PATH $PATH /usr/local/bin

# Sets necessary PATH defaults
set -g -x PATH $PATH /usr/bin /bin /usr/sbin /sbin

# Adds custom scripts to path.
set -g -x PATH $PATH $HOME/Library/Scripts/*

# =========
# Functions
# =========

# See help function and help alias for understanding aliases and functions.
# Since alias is just "a shellscript wrapper around the function builtin" I
# decided it was best to explicity define everything as a function.

# Better grep
function grr
  grep -riIn --color $argv
end

# Be nice
function please
  sudo $argv
end

# Because I'm an idiot
function yolo
  sudo $argv
end

# List all files colorized in long format, including dot files
function ll
  ls -al $argv
end

# IP addresses
# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
function ip
  curl icanhazip.com
end

function localip
  ipconfig getifaddr en1
end

function ips
  ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'
end

# Empty the Trash on all mounted volumes and the main HDD
function emptytrash
  sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash
end

# If you use Gist and the command line, you probably have “jist” installed. If not, run gem install jist and make
# your life easier. This extremely short alias is great for popping a clipboard straight to a public gist and opening
# the link in your browser.
# http://brettterpstra.com/2013/03/14/more-command-line-handiness/
function pbgist
  jist -Ppo
end

# Open Chrome
function chrome
  open -a "Google Chrome"
end

# Open Safari
function safari
  open -a "Safari"
end

# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
# make executable
function ax
  chmod a+x
end

# edit .bash_profile
function bp
  subl ~/.bash_profile
end

# edit config.fish (this file)
function cf
  subl ~/.config/fish/config.fish
end

# edit ~/.gitconfig
function gitconfig
  subl ~/.gitconfig
end

# reload your Fish config
function src
  . ~/.config/fish/config.fish; and clear
end

# list TODO/FIX lines from the current project
# Get ack via brew install ack. http://beyondgrep.com
function todos
  ack --nogroup '(TODO|FIX(ME)?):'
end

# list console.logs from the current project
function consolelogs
  ack --nogroup '(console\.log|console\.info)'
end

# Print the name of the current git branch.
function current_branch
  git branch | grep '*' | awk '{ print $2 }'
end

# Open path in Finder
# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
function f
  open -a Finder ./
end

# Eject drive from command line
function eject
  diskutil unmount
end

# List all brew recipes and gems installed
function installed
  brew list; and gem query --local
end

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
function stfu
  osascript -e 'set volume output muted true'
end

function pumpitup
  osascript -e 'set volume 10'
end

function hax
  growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'
end

# Open current directory in Sublime
function e
  subl . &
end

# Really lazy vim
function v
  vim
end

# Quick access to .vimrc
function vrc
  vim ~/.vimrc
end

# For browserstack.com
function browserstack
  java -jar BrowserStackTunnel.jar zkH9c4pryjoxhoAx4V7y localhost,3000,0
end

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
# Mute
function stfu
  osascript -e 'set volume output muted true'
end

# Set volume to 10.
function pumpitup
  osascript -e 'set volume 10'
end

# Pop-up
function hax
  growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'
end

# -------------------
# Stuff For Amplifier
# -------------------

# Cane for Ruby. To be ran before all merges to master.
function cane
  bundle exec cane --abc-glob '{app,lib,spec}/**/*.rb' --style-glob '{app,lib,spec}/**/*.rb' --style-measure 120 --gte 'coverage/covered_percent,90' --no-doc
end

# MEGA TEST
function megatest
  rake spec quality jshint js_quality jasmine:ci; and brakeman -q
end

function singletest
  rake spec SPEC=$argv
end
