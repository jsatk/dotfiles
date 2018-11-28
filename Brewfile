# Taps --------------------------------------------------------------------- {{{

tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
# For contacts in Mutt.
tap "keith/formulae"
# For `rcm`.
tap "thoughtbot/formulae"

# }}}
# Shells ------------------------------------------------------------------- {{{

brew "bash"
brew "bash-completion"
brew "fish"

# }}}
# Email -------------------------------------------------------------------- {{{

# Lets me look up contacts in macOS Contacts app.
brew "contacts-cli"
# Lets me fetch my email.
# Confusingly `isync` is the project name, but the executable is `mbsync`.
#
# From: http://isync.sourceforge.net
#
#   > While isync is the project name, mbsync is the current executable name;
#   > this change was necessary because of massive changes in the user
#   > interface. An isync executable still exists; it is a compatibility wrapper
#   > around mbsync.
brew "isync"
# Lets me read HTML-only emails from senders who don't respect us cave dwellers
# with plain text email clients.
brew "lynx"
# Lets me send email.
brew "msmtp"
# Lets me browse & read email.
brew "mutt"
# For email searching.
brew "notmuch"
# Lets me go to URLs in emails.
brew "urlview"

# }}}
# Version Control ---------------------------------------------------------- {{{

brew "git"
brew "gist"
brew "mercurial"
# CLI repository browsing.
brew "tig"

# }}}
# Chat --------------------------------------------------------------------- {{{

brew "irssi"

# }}}
# Programming Languages, DBs, & Language Tools ----------------------------- {{{

# node version manager.
brew "n"
# ruby version manager.
# NOTE: I don't really need to switch versions of ruby often, but installing
# ruby via homebrew directly is not advised.  And leveraging macOS's system
# ruby requires sudo and can generally be a pain.  So I'm installing rbenv so I
# can install my own user version of ruby and not deal with headaches.
brew "rbenv"
brew "go"
brew "postgresql"
brew "ruby-build"
brew "rust"
brew "sbt"
# I install node with `n`, so lets install `yarn` without it.
# And no, I don't want to install yarn via npm.  That's too oroboros for me.
brew "yarn", args: ["--without-node"]

# }}}
# Security ----------------------------------------------------------------- {{{

brew "openssl"
# Useful for printing GPG stuff to paper for physical backup.
brew "paperkey"
# For personalizing & working with Yubikeys.
brew "ykman"
brew "ykpers"
# For working with GPG stuff.
brew "pinentry-mac"

# }}}
# Utilities, etc. ---------------------------------------------------------- {{{

# General unix tools that it's good to have
brew "autoconf"
brew "automake"
brew "coreutils"
brew "libtool"
brew "libxslt"
brew "libyaml"
brew "readline"
brew "unixodbc"

# Allow me to use `j` to jump around my filesystem.
brew "autojump"
# Better `cat`.
brew "bat"
# For when I need to turn bluetooth back on & my trackpad is bluetooth.
brew "blueutil"
# Source code tag files.
brew "ctags"
# Better `find`.
brew "fd"
# Fuzzy-finder.
brew "fzf"
# For when I need to mess with fonts.
brew "fontforge"
# Add GitHub support to git on the command-line.
brew "hub"
# My blog CMS of choice.
brew "hugo"
# Utility for doing stuff – mostly compression – to images.
brew "imagemagick"
# For easy parsing and rendering of JSON.
brew "jq"
# CLI macOS app store.
brew "mas"
# Gives me `sponge`.
brew "moreutils"
# CLI file navigator.
brew "ranger"
# Manages dotfiles.
brew "rcm"
# Best `grep` replacement.
brew "ripgrep"
# Fancy ASCII print out of computer settings.
brew "screenfetch"
# Control spotify from commandline.  Mostly for adjusting volume when using
# Spotify Connect.
brew "shpotify"
# Simple & better `man`.
brew "tldr"
# The terminal multiplexer.
brew "tmux"
# Alternative to `rm` that moves things to the trash rather than destroys them
# forever.
brew "trash"
# Best text editor ever.
brew "vim"

# }}}
# Casks -------------------------------------------------------------------- {{{

cask_args appdir: "/Applications"

cask "alfred"
cask "backblaze"
cask "battle-net"
cask "dash"
cask "discord"
cask "docker"
cask "dropbox"
cask "droplr"
cask "fantastical"
cask "firefox"
cask "firefox-developer-edition"
cask "font-hack-nerd-font"
cask "google-chrome"
cask "google-chrome-canary"
cask "google-cloud-sdk"
cask "google-drive-file-stream"
cask "google-hangouts"
cask "iTerm2"
cask "java8" # For work.
cask "keybase"
cask "keycastr"
cask "mactex"
cask "rescuetime"
cask "signal"
cask "skype"
cask "slack-beta"
cask "spotify"
cask "steam"
cask "tor-browser"
cask "whatsapp"
cask "zeplin"
cask "zoomus"

# }}}
# macOS App Store ---------------------------------------------------------- {{{

mas "1Password 7", id: 1333542190
mas "Byword", id: 420212497
mas "Cardhop", id: 1290358394
mas "DaisyDisk", id: 411643860
mas "Deliveries", id: 924726344
mas "GarageBand", id: 682658836
mas "iMovie", id: 408981434
mas "Keynote", id: 409183694
mas "Marked 2", id: 890031187
mas "Monit", id: 1014850245
mas "Numbers", id: 409203825
mas "OmniFocus", id: 1346203938
mas "Pages", id: 409201541
mas "Pixelmator", id: 407963104
mas "Reeder", id: 880001334
mas "Soulver", id: 413965349
mas "Speedtest", id: 1153157709
mas "TaskPaper", id: 1090940630
mas "Tweetbot", id: 1384080005
mas "VPN Unlimited", id: 727593140
mas "Xcode", id: 497799835

# }}}

# vim: set syntax=ruby filetype=ruby
# textwidth=80
# foldmethod=marker foldmarker={{{,}}} foldlevelstart=0:
