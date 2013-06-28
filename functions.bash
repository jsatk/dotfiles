# Custom functions here.

# JS Lint
# Reference: http://blog.simplytestable.com/installing-jslint-for-command-line-use-on-ubuntu/
function jslint {
    filename=${1##*/} # Name of file.
    dir="/Users/Jesse/Desktop/" # Directory where you want your lint files output. Must be full path. No ~.
    path="$dir$filename-lint.js"
    /usr/local/bin/node /usr/share/node-jslint/node_modules/jslint/bin/jslint.js "$1" > "$path"
}

# cd to the path of the front Finder window
cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# Tail console. You can pass it a string to grep on.
function console () {
    if [[ $# > 0 ]]; then
        query=$(echo "$*"|tr -s ' ' '|')
        tail -f /var/log/system.log|grep -i --color=auto -E "$query"
    else
        tail -f /var/log/system.log
    fi
}

# JS Hint
function jsh {
    HINT_FILE=app/assets/javascripts/admin/${1} rake jshint
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