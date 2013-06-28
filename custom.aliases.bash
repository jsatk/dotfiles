#Better grep.
alias grr="grep -riIn --color"

# Cane for Ruby. To be ran before all merges to master.
alias cane="bundle exec cane --abc-glob '{app,lib,spec}/**/*.rb' --style-glob '{app,lib,spec}/**/*.rb' --style-measure 120 --gte 'coverage/covered_percent,90' --no-doc"

# MEGA TEST
alias rcb="rake && cane && brakeman -q && rake jshint"

# be nice
alias please=sudo

# List all files colorized in long format, including dot files
alias ll="ls -la ${colorflag}"

# Git stuff
# Undo a `git push`
alias gundopush="git push -f origin HEAD^:master"
# Pretty log
alias gprettylog='git log --name-only --decorate=full --pretty=fuller'
# Log Me
alias glogme='git log --name-only --decorate=full --pretty=fuller --author="Jesse"'

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

# http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
# make executable
alias ax="chmod a+x"
# edit .bash_profile
alias bp="$EDITOR ~/.bash_profile"
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

# Open current directory in Sublime
alias e='subl . &'

# Fix "Open With"
alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"