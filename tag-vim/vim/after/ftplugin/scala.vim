setlocal colorcolumn=120 " Width of Github diffs
setlocal textwidth=80
setlocal foldlevel=99 " Don't fold in scala.  The syntax for it is meh.  Until treesitter gets proper scala support folds ain't worth it.

" Needed for compltions _only_ if you aren't using completion-nvim
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
" As of this writing, 2021-03-08, Treesitter doesn't yet have great Scala
" support so we can't fold based on Treesitter.
setlocal foldmethod=syntax
