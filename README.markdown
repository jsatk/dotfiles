# dotfiles

## Table of Contents

* [🌐 Overview](#overview)
* [💻 Installation](#installation)
* [🙇 Attribution](#attribution)

## Overview

This is how I do computers.  If you want to do computers like me this is the repository for you.  It assumes an macOS environment.  If you run Linux or Windows then this repo may not be for you.

There's two main branches: `main` and `work`.  `work` is for my work computer.  If you're not me I'd recommend using `main`.

There's a `Makefile` that sets everything up.  Run `make help` to see available commands.  Running `make` with no arguments kicks off the default target.  It should *just work* ✨.  The biggest manual step is installing Homebrew first.  You'll need to do that before you run this.

It's important to note that I use [Fish Shell](https://fishshell.com).  If this scares you that's okay.  But you shouldn't be scared.  Fish Shell is amazing.

I use [Stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

As of this writing (10/10/2025) I've found using version managers for various languages to be more trouble than it's worth.  So I don't use `rbenv`, `nvm`, `asdf`, or anything like that.  I just install the latest version of everything via Homebrew and call it a day.

Questions?  Comments?  Open an issue.

## Installation

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Install Homebrew
git clone git@github.com:jsatk/dotfiles.git ~/.dotfiles # Clone this repo
cd ~/.dotfiles
stow bat curl fish git homebrew security tmux vim weechat wezterm # Symlink all the dots we want
make # Install all the things
```

Running `make` will set up all your dotfiles and install a ton of useful stuff like...

* Installs all the formulas, casks, and apps (from the macOS App Store) I want.
  * To see what's installed via homebrew view `homebrew/.Brewfile`.
* Installs some global npm packages and gems.
  * To see what gems & npm packages are installed checkout the `Makefile`.
* Create symlinks for all the dotfiles via [rcm](http://thoughtbot.github.io/rcm/rcm.7.html).
* Update everything!  This was design so that it can be ran repeatedly and be non-harmful.  It only installs stuff as needed.

If you plan on using this yourself you'll need to make sure to change all the stuff that's specific to me (like my email address & name) in the dotfiles.  Search for "Jesse" or "jsatk" and replace any mention of that with your own name, etc.

## References

Here's a list of links to instructions I often find myself needing to reference whenever I set up a new computer.

* How to safely move your GPG key from one machine to another. <https://gist.github.com/angela-d/8b27670bac26e4bf7c431715fef5cc51>
* This fixes the "gpg: WARNING: unsafe permissions on homedir '/home/path/to/user/.gnupg' " error while using Gnupg . <https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85>

## Attribution

Big thanks to these people for publishing their own dotfiles and allowing me to steal from them.

* [https://github.com/stephencelis/dotfiles](https://github.com/stephencelis/dotfiles)
* [https://github.com/nicknisi/dotfiles](https://github.com/nicknisi/dotfiles)
* [https://bitbucket.org/sjl/dotfiles](https://bitbucket.org/sjl/dotfiles)
* [https://github.com/gabebw/dotfiles](https://github.com/gabebw/dotfiles)
* [https://github.com/ckipp01/dots](https://github.com/ckipp01/dots)
