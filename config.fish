# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via fish_config command or in ~/.config/fish/functions/fish_prompt.fish

# ============
# Basics, etc…
# ============

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

# =========
# Functions
# =========
function ef -d 'Edit fish.config.'
  subl ~/.config/fish/config.fish
end

function ev -d 'Edit .vimrc'
  subl ~/.vimrc
end

function eh -d 'Edit .hgrc'
  subl ~/.hgrc
end

function et -d 'Edit .tmux.conf'
  subl ~/.tmux.conf
end

function eg -d 'Edit .gitconfig'
  subl ~/.gitconfig
end

function eb -d 'Edit .bash_profile'
  subl ~/.bash_profile
end

function grr -d 'Better grep. Not to be confused with ack.'
  grep -riIn --color $argv
end

function please -d 'Be nice.'
  sudo $argv
end

function yolo -d "Because I'm an idiot"
  sudo $argv
end

function ll -d 'List all files colorized in long format, including dot files.'
  ls -al $argv
end

function ip -d 'Print remote IP.'
  curl icanhazip.com
end

function localip -d 'Print local IP.'
  ipconfig getifaddr en1
end

function ips -d 'List IP addresses.'
  ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'
end

function emptytrash -d 'Empty the Trash on all mounted volumes and the main HDD.'
  sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash
end

# If you use Gist and the command line, you probably have “jist” installed. If not, run gem install jist and make
# your life easier. This extremely short alias is great for popping a clipboard straight to a public gist and opening
# the link in your browser.
# http://brettterpstra.com/2013/03/14/more-command-line-handiness/
function pbgist -d 'Popp clipboard straight to a public gist and open link in browser'
  jist -Ppo
end

function chrome -d 'Open Chrome'
  open -a "Google Chrome"
end

function safari -d 'Open Safari'
  open -a "Safari"
end

# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
function ax -d 'Make executable.'
  chmod a+x
end

function src -d 'Reload your Fish config'
  . ~/.config/fish/config.fish; and clear
end

function todos -d 'List TODO/FIXME lines from the current project. Requires ack: http://beyondgrep.com'
  ack --nogroup '(TODO|FIX(ME)?):'
end

function consolelogs -d 'List console.logs from the current project'
  ack --nogroup '(console\.log|console\.info)'
end

function current_branch -d 'Print the name of the current git branch.'
  git branch | grep '*' | awk '{ print $2 }'
end

function f -d 'Open path in Finder: http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/'
  open -a Finder ./
end

function eject -d 'Eject drive from command line'
  diskutil unmount
end

function installed -d 'List all brew recipes and gems installed'
  brew list; and gem query --local
end

function e -d 'Open current directory in Sublime'
  subl . &
end

function v -d 'Really lazy vim'
  vim $argv
end

function browserstack -d 'For browserstack.com'
  java -jar BrowserStackTunnel.jar zkH9c4pryjoxhoAx4V7y localhost,3000,0
end

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
function stfu -d 'Mute'
  osascript -e 'set volume output muted true'
end

function pumpitup -d 'Set volume to 10'
  osascript -e 'set volume 10'
end

function fixopenwith -d 'Fix the shitty OS X Open With menu duplicates'
    /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
    killall Finder
    echo 'Open With has been rebuilt, Finder will relaunch'
end

# ===================
# Stuff For Amplifier
# ===================

function megatest -d 'MEGA TEST'
  rake spec quality jshint js_quality jasmine:ci jasmine:ci_with_metrics -v -t; and brakeman -q
end

function singletest -d 'Run single rake spec'
  rake spec SPEC=$argv
end

# ======
# Prompt
# ======

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  echo

  set_color magenta
  printf '%s' (whoami)
  set_color normal
  printf ' at '

  set_color yellow
  printf '%s' (hostname|cut -d . -f 1)
  set_color normal
  printf ' in '

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
__terlar_git_prompt
  echo

  if test $last_status -eq 0
    set_color normal
    printf '><((°> '
  else
    set_color $fish_color_error
    printf '[%d] ><((ˣ> ' $last_status
  end

  set_color normal
end
