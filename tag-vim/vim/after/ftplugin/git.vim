" Add hanging indent auto-formatting for git commit messages.  Unfortunately
" the gitcommit settings in Vim-Fugitive don't handle hanging indents for
" bulleted lists.
setlocal comments+=fb:-,fb:*
setlocal formatoptions+=q
setlocal formatoptions+=2
setlocal formatoptions+=n
setlocal spell
