" See: `:h :SortScalaImports`
let g:scala_sort_across_groups=1

setlocal colorcolumn=120 " Width of Github diffs
setlocal textwidth=80
setlocal foldlevel=1

" Needed for compltions _only_ if you aren't using completion-nvim
setlocal omnifunc=v:lua.vim.lsp.omnifunc
