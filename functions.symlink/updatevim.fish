function updatevim --description 'Required to use Vundle. See: https://github.com/gmarik/Vundle.vim/wiki#faq4'
	set -lx SHELL (which sh)
    vim +BundleInstall! +BundleClean +qall
end
