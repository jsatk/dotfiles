" Title: .vimrc File
" Author: Jesse Atkinson
" Email: jesse.s.atkinson@gmail.com
" Twitter: @jsatk
" References: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"             https://github.com/paulirish/dotfiles/blob/master/.vimrc
"             http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
"             http://www.reddit.com/r/vim/
"             http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/
"             http://vimregex.com/
"             http://www.villustrator.com/

" The filetype and call lines are for loading Pathogen.
" See: http://www.vim.org/scripts/script.php?script_id=2332
" Currently commented out due to ePrize's Promodev environment not supporting Pathogen.
" filetype off
" call pathogen#runtime_append_all_bundles()
" filetype plugin indent on

" Make vim more useful
" Why am I including this? Better safe than sorry.
" http://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
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
" Note: This is a new feature in VIM 7.3. Not supported in prior versions.
set relativenumber

" Enable syntax highlighting
syntax on

" Show select “invisible” characters
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

" Display current cursor position in lower right corner.
set ruler

" Show the current mode
set showmode

" Show the current command
set showcmd

" Show the filename in the window titlebar
set title

" Start scrolling three lines before the horizontal window border
set scrolloff=3

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

" Fix the case-searching stuff to be how we want it. Ignore the case, unless there's caps in it, and then it's case sensitive.
set ignorecase
set smartcase

" Fix Vim's horribly broken default regex 'handling' by automatically inserting a \v before any string you search for.
nnoremap / /\v
vnoremap / /\v

" Add the g flag to search/replace by default
set gdefault

" Saves file on losing focus of VIM
au FocusLost * :wa

" Set the color scheme. Change this to your preference.
" Color schemes are located in ~/.vim/colors/
" Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
" List of favorites: inkpot, lettuce, lucius, molokai, solarized, tir_black, zenburn
colorscheme molokai

" Sets .tt2 files to be syntax highlighted as html and .flo to be highlighted as perl
augroup filesyntax
    autocmd!
    au BufNewFile,BufRead *.tt2 set filetype=html
    au BufNewFile,BufRead *.flo set filetype=perl
 augroup END

" On save strip trailing whitespace and convert line endings to Unix format
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
" & converts line endings to Unix format
augroup prewrites
    autocmd!
    autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

" Remaps leader key to an easier key
let mapleader = ","

" Ever notice a slight lag after typing the leader key + command?
" This lowers the timeout.
set timeoutlen=500

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>

" Sorts CSS properties. Most useful command ever.
" See: http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
nnoremap <leader>S :g#\({\n\)\@<=#.,/}/sort<CR>
:command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort

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
