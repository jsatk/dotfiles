#  ______     ______     ______     __  __     ______   ______     ______     ______   __     __         ______
# /\  == \   /\  __ \   /\  ___\   /\ \_\ \   /\  == \ /\  == \   /\  __ \   /\  ___\ /\ \   /\ \       /\  ___\
# \ \  __<   \ \  __ \  \ \___  \  \ \  __ \  \ \  _-/ \ \  __<   \ \ \/\ \  \ \  __\ \ \ \  \ \ \____  \ \  __\
#  \ \_____\  \ \_\ \_\  \/\_____\  \ \_\ \_\  \ \_\    \ \_\ \_\  \ \_____\  \ \_\    \ \_\  \ \_____\  \ \_____\
#   \/_____/   \/_/\/_/   \/_____/   \/_/\/_/   \/_/     \/_/ /_/   \/_____/   \/_/     \/_/   \/_____/   \/_____/
#

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/bash_profile
# Twitter:    @jsatk

# }}}
# Basics, etc… {{{

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# http://brettterpstra.com/2013/03/30/a-multi-purpose-editor-variable/
export EDITOR="vim"

# }}}
# Path {{{

# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Add Postgres to path
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# Sets PATH for executable scripts
export PATH=$PATH:$HOME/Library/Scripts

# }}}
# Bash Completion {{{

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# }}}
# Aliases {{{

# Be nice
alias please=sudo

# Because I'm an idiot
alias yolo=sudo

# List all files colorized in long format, including dot files
alias ll="ls -la ${colorflag}"

# IP addresses
# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
alias ip="curl icanhazip.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Lazy vim
alias v="vim"

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# If you use Gist and the command line, you probably have “jist” installed. If not, run gem install jist and make
# your life easier. This extremely short alias is great for popping a clipboard straight to a public gist and opening
# the link in your browser.
# http://brettterpstra.com/2013/03/14/more-command-line-handiness/
alias pbgist="jist -Ppo"

# Open Chrome
alias chrome="open -a \"Google Chrome\""

# Open Safari
alias safari="open -a \"Safari\""

# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
# make executable
alias ax="chmod a+x"
# edit .bash_profile
alias bp="$EDITOR ~/.bash_profile"
# edit .vimrc
alias ev="$EDITOR ~/.vimrc"
# edit keybindings.dict
alias kb="$EDITOR ~/Library/KeyBindings/DefaultKeyBinding.dict"
# reload your bash config
alias src="source ~/.bash_profile"

# list TODO/FIX lines from the current project
alias todos="ack -n --nogroup '(TODO|FIX(ME)?):'"

# Open path in Finder
# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
alias f='open -a Finder ./'

# Eject drive from command line
alias eject="diskutil unmount"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

# }}}
# Functions {{{

# Custom functions here.

# cd to the path of the front Finder window
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
  find . -name "$1"
}

# Syntax-highlight JSON strings or files
function json() {
  if [ -p /dev/stdin ]; then
    # piping, e.g. `echo '{"foo":42}' | json`
    python -mjson.tool | pygmentize -l javascript
  else
    # e.g. `json '{"foo":42}'`
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  fi
}

# Tail system log
function console () {
  if [[ $# > 0 ]]; then
    query=$(echo "$*"|tr -s ' ' '|')
    tail -f /var/log/system.log|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/system.log
  fi
}

# batch change extension
function chgext() {
  for file in *.$1 ; do mv $file `echo $file | sed "s/\(.*\.\)$1/\1$2/"` ; done
}

# Open find or dir in Alfred
# Select the current directory in launchbar, optionally a file
alf () {
  if [[ $# = 1 ]]; then
    [[ -e "$(pwd)/$1" ]] && open "x-alfred:select?file=$(pwd)/$1" || open "x-alfred:select?file=$1"
  else
    open "x-alfred:select?file=$(pwd)"
  fi
}

# Rename Tabs
# Reference: http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
function tabname {
  printf "\e]1;$1\a"
}

function winname {
  printf "\e]2;$1\a"
}

# For when you get angry
function fuck () { echo "Calm down"; }
function FUCK () { echo "Calm down"; }
function FUCKFUCK () { echo "Calm down"; }

# Fix the shitty OS X Open With menu duplicates
function fixopenwith() {
  /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
  killall Finder
  echo 'Open With has been rebuilt, Finder will relaunch'
}

# }}}
# Bash Prompt {{{

# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    MAGENTA=$(tput setaf 9)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 190)
    PURPLE=$(tput setaf 141)
    WHITE=$(tput setaf 256)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  MAGENTA="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  BOLD=""
  RESET="\033[m"
fi

function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

PS1="\n\[$RESET\]┌─▪\[\e]2;$PWD\[\a\]\[\e]1;\]$(basename "$(dirname "$PWD")")/\W\[\a\]\[${BOLD}${MAGENTA}\]\u \[$WHITE\]on \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\]\n└─▪ "

# }}}
# Stuff for tools, etc... {{{

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# For autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/jesseatkinson/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/jesseatkinson/google-cloud-sdk/completion.bash.inc'

# }}}
