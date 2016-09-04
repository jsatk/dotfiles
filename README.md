# Jesse's dotfiles.

This is how I do computers.  If you want to do computers like me this is the repository for you.  It assumes an OS X environment.  If you run Linux or windows then this repo may not be for you.

It's important to note that I use Fish Shell.  If this scares you that's okay.  But you shouldn't be scared.

* Fish Shell configuration
* Bash configuration
* vim configuration
* tmux configuration
* git configuration
* Makefile that sets it all up

# Install

Just run `make` and this will set up all your dotfiles and install a ton of useful stuff like...

* Symlinks for `.bash_profile`, `.gitconfig`, `.irbrc`, `.muttrc`, `.tmux.conf`, `.vimrc`, and the `.config` folder which houses my `config.fish` and fish `functions` folder.
* Installs [homebrew](http://brew.sh) all the formulae I tend to want as well as global `npm` packages I use.
* Update everything!  This was design so that it can be ran repeatedly and be non-harmful.  It only installs stuff as needed.

# References

Big thanks to these people who are much smarter than me for publishing their own dotfiles and allowing me to steal from them.

* [https://github.com/stephencelis/dotfiles](https://github.com/stephencelis/dotfiles)
* [https://github.com/nicknisi/dotfiles](https://github.com/nicknisi/dotfiles)
* [https://bitbucket.org/sjl/dotfiles](https://bitbucket.org/sjl/dotfiles)
* [https://github.com/paulirish/dotfiles](https://github.com/paulirish/dotfiles)
