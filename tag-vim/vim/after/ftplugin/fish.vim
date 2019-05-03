setlocal tabstop=4
setlocal equalprg=fish_indent
setlocal foldmethod=marker foldmarker={{{,}}}
" The line below sets up :make to use fish for syntax checking.
compiler fish
