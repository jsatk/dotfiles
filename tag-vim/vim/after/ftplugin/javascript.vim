setlocal foldmethod=syntax

" JSRequireToImport {{{

" Turns this:
"
"   ```
"   const React = require("react");
"   const {Provider, connect} = require("react-redux");
"   ```
"
" Into this:
"
"   ```
"   import React from "react";
"   import {Provider, connect} from "react-redux";
"   ```
"
function! JSRequireToImport()
  execute "keepjumps normal! ^ciwimport\<esc>f=cf(from \<esc>f)a\<backspace>\<esc>"
endfunction
nnoremap <leader>f :call JSRequireToImport()<cr>

" }}}
