" The filetype and call lines are for loading Pathogen.
" See: http://www.vim.org/scripts/script.php?script_id=2332
" Currently commented out due to promodev not supporting Pathogen.
" filetype off
" call pathogen#runtime_append_all_bundles()
" filetype plugin indent on

" Make vim more useful
set nocompatible
" Prevents some security exploits having to do with modelines in files.
set modelines=0
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Sets number of available colors
set t_Co=256
" Enable line numbers
set number
" Sets my background to dark
set background=dark
" Don’t add empty newlines at the end of files
set binary
set noeol
" Make tabs as wide as four spaces
set softtabstop=4
set tabstop=4
" Controls how many spaces to indent when using >>
set shiftwidth=4
set expandtab
" Highlight current line
set cursorline
" Changes Vim's line number column to display how far away each line is
" from the current one, instead of showing the absolute line number.
set relativenumber
" Enable syntax highlighting
syntax on
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show the current command
set showcmd
" Show the filename in the window titlebar
set title
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" set smarttab
" set smartindent
" set cindent
" set cinkeys=0{,0},!^F,o,O,e
" Indents properly
set autoindent
" Turns line wrapping on
set wrap
" Turns syntax highlighting on
syntax on
" Distiguishes between filetypes
filetype on

" Highlight matching braces as you type.
set showmatch

" Fix the case-searching stuff to be how we want it.  Ignore the case, unless there's caps in it, and then it's case sensitive.
set ignorecase
set smartcase
" Fix Vim's horribly broken default regex 'handling' by automatically inserting a \v before any string you search for.
nnoremap / /\v
vnoremap / /\v
" Add the g flag to search/replace by default
set gdefault

" Saves file on losing focus of VIM
au FocusLost * :wa

" Sets the terminals colors to 256 and the colorscheme to solarized
let g:solarized_termcolors=256
colorscheme solarized

" Sets .tt2 files to be syntax highlighted as html
augroup filesyntax
    autocmd!
    au BufNewFile,BufRead *.tt2 set filetype=html
    au BufNewFile,BufRead *.flo set filetype=perl
 augroup END

" Auto commands to run on write of file.
" Alternate way to strip trailing whitespace
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
" & converts line endings to Unix format
augroup prewrites
    autocmd!
    autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

" Remaps leader key to an easier key
let mapleader = ","

" Strip trailing whitespace command
noremap <leader>ss :call StripWhitespace ()<CR>

" Sorts CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Lets me open my .vimrc on the fly to quickly add useful stuff to it.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" New Vim users will want the following lines to teach them to do things right
" For training only. Remove when need be.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
