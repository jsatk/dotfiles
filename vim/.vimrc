" 0 preamble ------------------------------------------------------ {{{1
"
" Jesse Atkinson | jesse@jsatk.us | @jsatk | https://jsatk.us
"
" My ".vimrc" contains configures options which are core to Vim and
" are enumerated by the `:options` command. It groups the options
" into the same sections given by that command and in the same order
" for reference.
"
" Occasionally, each section contains other mappings or variable
" settings relevant to the options adjacent to them.
"
" It's also worth noting that a lot of options you might expect to be
" set aren't.  The reason for that is many of the most common and
" sensible options are set in tpope's vim-sensible, which I use.  So if
" you're wondering why I don't have `set wildmenu`, etc., in here it's
" because it's set in vim-sensible.
"
" All plugins are using vim's built-in package manager.  Plugins are
" cloned to ~/.vim/pack/.  This .vimrc assumes the following plugins are
" installed:
"
" * https://github.com/catppuccin/vim
" * https://github.com/tpope/vim-sensible

" 1 important ----------------------------------------------------- {{{1

" A |sentence| has to be followed by two spaces after the '.', '!' or '?'.
" See: https://stevelosh.com/blog/2012/10/why-i-two-space/#s6-power
set cpo+=J

" 2 moving around, searching and patterns ------------------------- {{{1

set ignorecase " Ignore the case, unless...
set smartcase  " ...there's caps in it.

" 3 tags ---------------------------------------------------------- {{{1

" 4 displaying text ----------------------------------------------- {{{1

set scrolloff=3
set linebreak
set breakindent
set showbreak=↪
set lazyredraw
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" 5 syntax, highlighting and spelling ----------------------------- {{{1

syntax on
colorscheme catppuccin_mocha " See: https://github.com/catppuccin/vim

set background=dark
set synmaxcol=800
set hlsearch
set termguicolors
set cursorline

" Stolen from Steve Losh
"
" There are three dictionaries I use for spellchecking:
"
"   /usr/share/dict/words
"   Basic stuff.
"
"   ~/.vim/custom-dictionary.utf-8.add
"   Custom words (like my name).  This is in my (version-controlled) dotfiles.
"
"   ~/.vim-local-dictionary.utf-8.add
"   More custom words.  This is *not* version controlled, so I can stick
"   work stuff in here without leaking internal names.
"
" I also remap zG to add to the local dict (vanilla zG is useless anyway).
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add
nnoremap zG 2zg

" Comments in italics
highlight Comment cterm=italic

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" 6 multiple windows ---------------------------------------------- {{{1

set hidden
set splitbelow
set splitright

" 7 multiple tab pages -------------------------------------------- {{{1

" 8 terminal ------------------------------------------------------ {{{1

set title
set ttyfast

" 9 using the mouse ----------------------------------------------- {{{1

if has('mouse')
  set mouse=a
endif

" 10 printing ----------------------------------------------------- {{{1

" 11 messages and info -------------------------------------------- {{{1

set showcmd
set showmode
set shortmess+=c
set shortmess-=F

" 12 selecting text ----------------------------------------------- {{{1

" 13 editing text ------------------------------------------------- {{{1

set undofile " Maintain undo history between sessions.
" The extra slash on the end saves files under the name of their full path
" with the / character replaced with a %.
set undodir=~/.vim/tmp/undo// " undo files live here.
set textwidth=0
set wrapmargin=0
set dictionary=/usr/share/dict/words
set showmatch
set nrformats=octal,hex,alpha " Increment alpha strings with Vim.

" Make the undo directory automatically if it doesn't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" 14 tabs and indenting ------------------------------------------- {{{1

set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab

" 15 folding ------------------------------------------------------ {{{1

set foldenable
set foldlevelstart=0

nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's
" partially open.
nnoremap zO zczO

" Stolen from Steve Losh.
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" 16 diff mode ---------------------------------------------------- {{{1

" 17 mapping ------------------------------------------------------ {{{1

" This section contains the few options that are under `17 mapping` in
" `:options` as well as all of my custom remappings that don't sensibily
" fit in another section.  For example, the folding remappings I have
" live  under `15 folding` but my `S` mapping for splitting lines lives
" here.

set timeoutlen=500

let mapleader = ","
let maplocalleader = "\\"
" Split line (sister to [J]oin lines)
nnoremap S i<cr><esc><right>
" switch to last file
nnoremap <leader><leader> <c-^>
" redraw the buffer
nnoremap <leader>r :syntax sync fromstart<cr>:redraw!<cr>
" Don't jump-to-next when I use * to search for what's under cursor.
nnoremap * *<c-o>
" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <c-l> :nohlsearch<cr><c-l>
" [Y]ank until end of line.  Makes Y behave like D and other
" do-until-end-of-line operations.
nnoremap n Y y$

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Clean trailing whitespace.
nnoremap <leader><space> mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" My garbage brain can't ever remember digraph codes.
inoremap <c-k><c-k> <esc>:help digraph-table<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" 18 reading and writing files ------------------------------------ {{{1

set autowrite
set backupdir=~/.vim/tmp/backup// " backups

" Create directory if it doesn't already exist.
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

" 19 the swap file ------------------------------------------------ {{{1

set directory=~/.vim/tmp/swap//
set nobackup
set nowritebackup
set noswapfile

" Create directory if it doesn't already exist.
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" 20 command line editing ----------------------------------------- {{{1

set wildmode=list:longest

" 21 executing external commands ---------------------------------- {{{1

" 22 running make and jumping to errors --------------------------- {{{1

" 23 language specific -------------------------------------------- {{{1

" 24 multi-byte characters ---------------------------------------- {{{1

" > When on all Unicode emoji characters are considered to be full
" > width.
"
" Emoji of different byte lengths render funky in Vim w/o this
" turned off.
set noemo

" 25 various ------------------------------------------------------ {{{1

set gdefault

" The following settings aren't under `:options` at all, so it made the
" most sense to throw them in the `25 various` junk-drawer.
set mousehide
set nostartofline

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  autocmd!

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

set secure " Disables unsafe commands in project-specific .vimrc files.
set exrc " Allows for project-specific vimrc files.

" vim: set foldmethod=marker foldlevel=0 textwidth=72:
