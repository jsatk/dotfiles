" Title: .vimrc File
" Author: Jesse Atkinson
" Email: jesse.atkinson@me.com
" Twitter: @jsatk
" References: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"             https://github.com/paulirish/dotfiles/blob/master/.vimrc
"             http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
"             http://www.reddit.com/r/vim/
"             http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/
"             http://vimregex.com/

" The filetype and call lines are for loading Pathogen.
" See: http://www.vim.org/scripts/script.php?script_id=2332
execute pathogen#infect()
syntax on
filetype plugin indent on

" Make vim more useful
" Why am I including this? Better safe than sorry.
" http://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Prevents some security exploits having to do with modelines in files.
set modelines=0

" Enhance command-line completion
set wildmenu

" Auto-completion menu
set wildmode=list:longest

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

" Don’t add empty newlines at the end of files
set binary
set noeol

" Make tabs as wide as two spaces
set softtabstop=2
set tabstop=2

" Controls how many spaces to indent when using >>
set shiftwidth=2
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

" Set incremental searching
set incsearch

" Fix the case-searching stuff to be how we want it. Ignore the case, unless there's caps in it, and then it's case sensitive.
set ignorecase
set smartcase

" Enable code folding
set foldenable

" Hide mouse when typing
set mousehide

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

" Show command in bottom right portion of the screen
set showcmd

" Show the filename in the window titlebar
set title

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Indents properly
set autoindent

" Turns line wrapping on
set wrap

" Distiguishes between filetypes
filetype on

" Highlight matching braces as you type.
set showmatch

" Fix Vim's horribly broken default regex 'handling' by automatically inserting a \v before any string you search for.
" I don't really dig this but some might. Leaving here and commented out.
" nnoremap / /\v
" vnoremap / /\v

" Add the g flag to search/replace by default
set gdefault

" Saves file on losing focus of VIM
au FocusLost * :wa

" Color scheme stuff!
" Color schemes are located in ~/.vim/colors/
" Here's the top 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
" List of favorites: inkpot, lettuce, lucius, molokai, solarized, tir_black, zenburn
" You can make your own colorschemes here: http://www.villustrator.com/
" Solarized can be found here: http://ethanschoonover.com/solarized
" Sets my background to either light or dark in solarized colorscheme
" set background=dark
" Needed for use of Solarized in Terminal.app.
let g:solarized_termcolors=256
colorscheme molokai

" Set font type and size. Depends on the resolution. Larger screens, prefer h20
" Inconsolata can be found here: http://levien.com/type/myfonts/inconsolata.html
set guifont=Inconsolata:h24

" Sets .tt2 files to be syntax highlighted as html and .flo to be highlighted as perl
augroup filesyntax
    autocmd!
    au BufNewFile,BufRead *.tt2 set filetype=html
    au BufNewFile,BufRead *.flo set filetype=perl
 augroup END

" On save strip trailing whitespace and convert line endings to Unix format
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
augroup prewrites
    autocmd!
    autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

" Source the .vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
augroup myvimrchooks
    autocmd!
    autocmd bufwritepost .vimrc source ~/.vimrc
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

" Set up an HTML5 template for all new .html files
autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl

" Sorts CSS properties. Most useful command ever.
" See: http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
nnoremap <leader>S :g#\({\n\)\@<=#.,/}/sort <bar> :%s/:\(\S\+;\)/: \1/g<CR>
:command! BeautifyCSS :g#\({\n\)\@<=#.,/}/sort <bar> %s/:\(\S\+;\)/: \1/g

" Super retab: http://vim.wikia.com/wiki/Super_retab
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" Lets me open my .vimrc on the fly to quickly add useful stuff to it.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"Shortcut to fold tags with leader (set to ,) + ft
nnoremap <leader>ft Vatzf

"Map code completion to , + tab
imap <leader><tab> <C-x><C-o>

" Some might be interested in this article.
" Make Vim completion popup menu work just like in an IDE
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE

" Bubble single lines (kicks butt)
" http://vimcasts.org/episodes/bubbling-text/
" Due to OS X keybinding of the C-Up key, I chose to remap to C-k and so forth.
nmap <C-k> ddkP
nmap <C-j> ddp

" Bubble multiple lines
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Easier window navigation
" Commented out due to Bubbling key bindings above.
" nmap <C-h> <C-w>h
" nmap <C-j> <C-w>j
" nmap <C-k> <C-w>k
" nmap <C-l> <C-w>l

" New Vim users will want the following lines to teach them to do things right
" For training only. Remove when need be.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap k gk
nnoremap j gj
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>