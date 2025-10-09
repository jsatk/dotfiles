" Make vim resize on host window resize.  Great for increasing/decreasing
" font or when you disconnect from your external monitor.
autocmd VimResized * wincmd =
autocmd FileType help setlocal textwidth=80
autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

setlocal textwidth=80
setlocal foldmethod=marker
