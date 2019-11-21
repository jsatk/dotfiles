setlocal foldmethod=syntax
" Metals prints some wordy messages that get cut off when cmdheight is set to
" the default of 1.
setlocal cmdheight=2

command! -nargs=0 MetalsImport
  \ call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' })

command! -nargs=0 MetalsConnect
  \ call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-connect' })
