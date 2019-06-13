# dotfiles

## Table of Contents

* [🌐 Overview](#overview)
* [💻 Installation](#installation)
* [🙇 Atribution](#attribution)

## Overview

This is how I do computers.  If you want to do computers like me this is the repository for you.  It assumes an macOS environment.  If you run Linux or Windows then this repo may not be for you.

There's a `Makefile` that sets everything up.  Run `make help` to see available commands.  Running `make` with no arguments kicks off the default target.  It should *just work* ✨.  If it doesn't please open an [issue](https://github.com/jsatk/dotfiles/issues) [email me](mailto:jesse@jsatk.us).

It's important to note that I use [Fish Shell](https://fishshell.com).  If this scares you that's okay.  But you shouldn't be scared.  Fish Shell is amazing.  Bash is also fully supported but I don't spend my day-to-day in it so it's possible I might miss keeping it as up-to-date as my fish stuffs.

Pretty much every file & folder in this directory gets symlinked into my `~` folder and prepended with a `.` via [rcm](http://thoughtbot.github.io/rcm/rcm.7.html).

Questions?  Comments?  Open an issue or tweet [@jsatk](https://twitter.com/jsatk).

## Installation

```sh
$ git clone git@github.com:jsatk/dotfiles.git ~/.dotfiles # Installing in ~/.dotfiles is important.
$ cd ~/.dotfiles
$ make
```

Running `make` will set up all your dotfiles and install a ton of useful stuff like...

* Installs [homebrew](http://brew.sh).
* Installs all the formulas, casks, and apps (from the macOS App Store) I want.
    * To see what's installed via homebrew checkout the `Brewfile`.
* Installs various versions of languages via [asdf](https://github.com/asdf-vm/asdf) (no nvm, rvm, etc.).
* Installs some global npm packages and gems.
    * To see what gems & npm packages are installed checkout the `Makefile`.
* Create symlinks for all the dotfiles via [rcm](http://thoughtbot.github.io/rcm/rcm.7.html).
* Update everything!  This was design so that it can be ran repeatedly and be non-harmful.  It only installs stuff as needed.

If you plan on using this yourself you'll need to make sure to change all the stuff that's specific to me (like my email address & name) in the dotfiles.  Search for "Jesse" or "jsatk" and replace any mention of that with your own name, etc.

## Attribution

Big thanks to these people for publishing their own dotfiles and allowing me to steal from them.

* [https://github.com/stephencelis/dotfiles](https://github.com/stephencelis/dotfiles)
* [https://github.com/nicknisi/dotfiles](https://github.com/nicknisi/dotfiles)
* [https://bitbucket.org/sjl/dotfiles](https://bitbucket.org/sjl/dotfiles)
* [https://github.com/gabebw/dotfiles](https://github.com/gabebw/dotfiles)
