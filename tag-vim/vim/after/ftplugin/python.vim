" Ignore compiled python
setlocal wildignore=*.pyc
setlocal foldmethod=indent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

let g:netrw_list_hide= '.*\.pyc$'

" For ALE plugin.
let b:ale_linters = ['pyls', 'flake8', 'mypy', 'pylint']
