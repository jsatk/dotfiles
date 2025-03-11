# Taps -------------------------------------------------------------------- {{{1

tap "coursier/formulas"
tap "github/gh"
tap "hashicorp/tap"
tap "homebrew/cask-fonts"
tap "keith/formulae"
tap "thoughtbot/formulae"
tap "caarlos0/tap"
tap "jesseduffield/lazygit"
tap "Virtuslab/scala-cli"

# Shells ------------------------------------------------------------------ {{{1

brew "bash-completion"
brew "fish"

# Email ------------------------------------------------------------------- {{{1

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
# Lets me send email.
brew "msmtp"
# Lets me browse & read email.
brew "neomutt"
# For email searching.
brew "notmuch"
# Lets me go to URLs in emails.
brew "urlview"
# Lets me read HTML-only emails from senders who don't respect us cave dwellers
# with plain text email clients.
brew "w3m"

# Version Control --------------------------------------------------------- {{{1

brew "gist"
brew "git"
brew "git-delta"
brew "lazygit"
brew "mercurial"
brew "tig"

# Chat -------------------------------------------------------------------- {{{1

# IRC
brew "weechat"

# Programming Languages, DBs, & Language Tools ---------------------------- {{{1

# terminal recording.
brew "asciinema"
# Program language version manager.  Manages all languages.
brew "asdf"
# brew "bloop" # Disabling until it's supported on M1 Macs.  For now install
# bloop via `cs install bloop-jvm`.  The binary is then titled `bloop-jvm`, not
# `bloop`.
# See here for more details: https://github.com/scalacenter/bloop/issues/1467
brew "coursier"
brew "ghcup"
brew "lua-language-server"
brew "luarocks"
brew "mysql"
brew "nginx"
brew "ruby-build"
brew "scala-cli"

# Security ---------------------------------------------------------------- {{{1

brew "hopenpgp-tools"
brew "openssl"
# For working with GPG stuff.
brew "pinentry-mac"
# For personalizing & working with Yubikeys.
brew "ykman"
brew "ykpers"
brew "yubikey-personalization"

# Utilities, Games, etc. -------------------------------------------------- {{{1

# General unix tools that it's good to have
brew "autoconf"
brew "automake"
brew "coreutils"
brew "libtool"
brew "libxslt"
brew "libyaml"
brew "readline"
brew "rlwrap"
brew "unixodbc"
brew "unzip"
brew "wget"

# Allow me to use `j` to jump around my filesystem.
brew "autojump"
# Better `cat`.
brew "bat"
# For when I need to turn bluetooth back on & my trackpad is bluetooth.
brew "blueutil"
# Better top – written in Rust, because we have to rewrite everything in Rust or
# Go now.
brew "bottom"
# Source code tag files.
brew "ctags"
# `ls` but written in Rust with better defaults.
brew "lsd"
# Better `find`.
brew "fd"
# Fuzzy-finder.
brew "fzf"
# For when I need to mess with fonts.
brew "fontforge"
# GitHub CLI tool.  As of this writing (20200218) is in beta and thus I still
# need hub (see below).
brew "gh"
# Make pretty graphs.
brew "graphviz"
# My blog CMS of choice.
brew "hugo"
# Utility for doing stuff – mostly compression – to images.
brew "imagemagick"
# For easy parsing and rendering of JSON.
brew "jq"
# CLI macOS app store.
brew "mas"
# Slide decks in plain-text Markdown rendered in the Terminal.
brew "mdp"
# Gives me `sponge`.
brew "moreutils"
# When I need to SSH.
brew "mosh"
# Media player.
brew "mpv"
# Disk usage analysis tool.  Like DaisyDisk but CLI.
brew "ncdu"
# Manages dotfiles.
brew "rcm"
# Best `grep` replacement.
brew "ripgrep"
# Fancy ASCII print out of computer settings.
brew "neofetch"
# A sleep timer with progress.
brew "timer"
# Simple & better `man`.
brew "tldr"
# The terminal multiplexer.
brew "tmux"
# Alternative to `rm` that moves things to the trash rather than destroys them
# forever.
brew "trash"
# Display directories as trees.
brew "tree"
# Best text editor ever & it's cousin.
brew "vim"
brew "neovim"
# For easy parsing and rendering of Yaml.
brew "yq"

# Casks ------------------------------------------------------------------- {{{1

cask_args appdir: "/Applications"

cask "alfred"
cask "corretto"
cask "discord"
cask "docker"
cask "droplr"
cask "figma"
cask "intellij-idea-ce"
cask "steam"
cask "vlc"
cask "wezterm"
cask "yubico-yubikey-manager"
cask "zoom"

# macOS App Store --------------------------------------------------------- {{{1

mas "DaisyDisk", id: 411643860
mas "Deliveries", id: 290986013
mas "GarageBand", id: 682658836
mas "Keynote", id: 409183694
mas "Magnet", id: 441258766
mas "Marked 2", id: 890031187
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Things", id: 904280696
mas "Xcode", id: 497799835

# vim: filetype=ruby:textwidth=80:foldmethod=marker foldlevel=0
