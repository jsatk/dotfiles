"  __   __   __     __    __     ______     ______
" /\ \ / /  /\ \   /\ "-./  \   /\  == \   /\  ___\
" \ \ \'/   \ \ \  \ \ \-./\ \  \ \  __<   \ \ \____
"  \ \__|    \ \_\  \ \_\ \ \_\  \ \_\ \_\  \ \_____\
"   \/_/      \/_/   \/_/  \/_/   \/_/ /_/   \/_____/

" Preamble {{{

" Author:   Jesse Atkinson
" Email:    jesse@jsatk.us
" Source:   https://github.com/jsatk/dotfiles/blob/master/vimrc
" Twitter:  @jsatk

" References: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"             https://github.com/paulirish/dotfiles/blob/master/.vimrc
"             http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
"             http://www.reddit.com/r/vim/
"             http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/
"             http://vimregex.com

" Special thanks to Steve Losh, Tim Pope, and Jess Frazelle who I have stolen *so* much from.
" Sincerely thank you.

" }}}
" Vundle {{{

" Make vim more useful
" Why am I including this?  Better safe than sorry.
" http://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Vim needs a more POSIX compatible shell than fish for certain functionality
" to work, such as :%!, compressed help pages and many third-party addons.  If
" you use fish as your login shell or launch Vim from fish, you need to set
" shell to something else in your ~/.vimrc.
" Seriously... god dammit Vim.
if &shell =~# 'fish$'
  set shell=sh
endif

" Distiguishes between filetypes.  It is required to be set to 'off' for Vundle.
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Our Vim plugins!
Plugin 'burnettk/vim-angular'                   " Provides some nicities for working with AngularJS.
Plugin 'ctrlpvim/ctrlp.vim'                     " True fuzzy find.  The greatest thing ever for us lazy folk.
Plugin 'derekwyatt/vim-scala'                   " Makes working with Scala easier
Plugin 'derekwyatt/vim-sbt'                     " Adds very basic support for SBT
Plugin 'editorconfig/editorconfig-vim'          " Maintain consistent coding styles between different editors and IDEs.
Plugin 'embear/vim-localvimrc'                  " Allows you to use local vimrcs on a per-project basis.
Plugin 'ensime/ensime-vim'                      " Adds support for Ensime plugin that gives me IDE-like stuffs when working with Scala
Plugin 'fatih/vim-go'                           " Makes working with Go easier
Plugin 'flazz/vim-colorschemes'                 " All the colorschemes money can buy
Plugin 'gmarik/Vundle.vim'                      " Alternative to Pathogen.  Lovely plugin manager for vim.
Plugin 'junegunn/goyo.vim'                      " Makes working with plain text/markdown nicer
Plugin 'junegunn/vim-easy-align'                " Aligns multiple lines on any given point.  Useful for assignments.
Plugin 'jsatk/vim-fish'                         " Fish Shell syntax highlighting for vim.  Fork of dag/vim-fish as that repo is abandoned.
Plugin 'mattn/gist-vim'                         " Send text straight to a gist
Plugin 'mustache/vim-mustache-handlebars'       " Mustache & Handlebars support
Plugin 'othree/javascript-libraries-syntax.vim' " Provides syntax for many popular JavaScript libraries.
Plugin 'pangloss/vim-javascript.git'            " Adds some javascript nicities.
Plugin 'Raimondi/delimitMate'                   " Provides auto closing of parens, braces, and brackets in insert mode.
Plugin 'scrooloose/nerdtree.git'                " A vim explorer replacement.  Much nicer and easier to use.
Plugin 'scrooloose/syntastic'                   " Adds error checking while writing or on save in vim.
Plugin 'tmhedberg/SimpylFold'                   " Python code folding
Plugin 'tpope/vim-commentary'                   " Easier comment support in vim.  Comment out blocks with gcc.
Plugin 'tpope/vim-dispatch'                     " Terminal in your vim.  Works best with tmux.
Plugin 'tpope/vim-fugitive'                     " Git support in vim.  Incredible handy for merge conflicts.
Plugin 'tpope/vim-sensible.git'                 " A universal set of defaults that (hopefully) everyone can agree on.
Plugin 'tpope/vim-unimpaired'                   " Provides some nice key mappings
Plugin 'vim-airline/vim-airline'                " Adds a gorgeous toolbar with useful info to bottom of vim.
Plugin 'vim-airline/vim-airline-themes'         " Airline themes.  Self explanatory
Plugin 'vim-scripts/BufOnly.vim'                " Close all buffers except the current
Plugin 'wesQ3/vim-windowswap'                   " Swap windows without fucking up layout

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}
" Basic Options {{{

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

" Show line number
" Show relative line numbers
" Since we are also showing the line number then the line we are on will
" show its number but all surrounding lines will show their relative number.
" set number
" set relativenumber

" Tabs and Spaces
set expandtab   " Make sure that every file uses spaces, not tabs
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line

" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Highlight current line
set cursorline

" Enable syntax highlighting
syntax on

" Show select “invisible” characters
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮

" Prevents redrawing during automated tasks.
set lazyredraw

set showbreak=↪

" Highlight searches
set hlsearch

" When on, splitting a window will put the new window below the current one.
set splitbelow

" When on, splitting a window will put the new window right of the current one.
set splitright

" Allows jumping between splits with Ctrl + movement keys.
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread

" Write the contents of the file, if it has been modified, on each
" :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
" :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
" '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
set autowrite

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Set incremental searching
set incsearch

" Fix the case-searching stuff to be how we want it.  Ignore the case, unless there's caps in it, and then it's case sensitive.
set ignorecase
set smartcase

" Enable code folding
set foldenable

" Don't open my files with fucking folds, Vim.
set foldlevelstart=20

" Hide mouse when typing
set mousehide

" Always show status line
set laststatus=2

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Goddammit vim.  Make fucking backspace/delete on OS X work correctly.
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Display current cursor position in lower right corner.
set ruler

" Show the current mode
set showmode

" Show command in bottom right portion of the screen
set showcmd

" Show the filename in the window titlebar
set title

" Vim will wrap long lines at a character in 'breakat' rather
" than at the last character that fits on the screen.  Unlike
" 'wrapmargin' and 'textwidth', this does not insert <EOL>s in the file,
" it only affects the way the file is displayed, not its contents.
set linebreak

" Turns line wrapping on
set wrap

" wrap lines without changing the amount of indent.
set breakindent

" Turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0
set wrapmargin=0

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Highlight matching braces as you type.
set showmatch

" Tenths of a second to show the matching paren, when 'showmatch' is set.
set matchtime=3

" Add the g flag to search/replace by default
set gdefault

" Saves file on losing focus of VIM
autocmd FocusLost * :wa

" Remaps leader key to an easier key
let mapleader = ","

" I don't know how to use ex mode and it scares me.
map Q <Nop>

" Ever notice a slight lag after typing the leader key + command?
" This lowers the timeout.
set timeoutlen=500

" Highlight column 120 as a soft reminder
" Disabling for now 'cause it's annoying me.
" set colorcolumn=120

" Increment alpha strings with vim
" https://blog.mozilla.org/jv/2011/01/12/incrementing-alpha-strings-with-vim/
set nf=octal,hex,alpha

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Do not show stupid q: window
map q: :q

" Make vim resize on host window resize.  Great for increaseing/decreasing
" font or when you disconnect from your external monitor.
autocmd VimResized * wincmd =

" }}}
" Spelling {{{

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
"   work stuff in here without leaking internal names and shit.
"
" I also remap zG to add to the local dict (vanilla zG is useless anyway).
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add
nnoremap zG 2zg

" }}}
" Look & Feel {{{

" Many colorschemes support both light and dark backgrounds.  Dark is nicer on my eyes.
set background=dark

" Color schemes are located in ~/.vim/colors/
" Here's the top 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
" List of favorites: onedark, Tomorrow-Night, Tomorrow-Night-Eighties, railscasts, badwolf, lucius, molokai, solarized
" You can make your own colorschemes here: http://www.villustrator.com/
" I'm importing a fuck-ton of colorschemes via this plugin: github.com/flazz/vim-colorschemes
colorscheme Tomorrow-Night

" Sets the ColorColumn to a sensible color.
highlight ColorColumn ctermbg=237 guibg=#3a3a3a

" Sets the background as transparent (i.e. Uses your Terminal's background color/image)
" This is probably stupid, but giving it a whirl. 🤔
" highlight Normal guibg=NONE
" highlight Normal ctermbg=NONE

" Set's comments to italics
" Reference: https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/
" I realize setting t_ZH and t_ZR directly is probably 'bad' to more advanced
" vim folks.  Practicality beats purity. ¯\_(ツ)_/¯
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic

" Set font type and size.  Depends on the resolution.  Larger screens, prefer h20
" My two favorite programming typefaces are Operator Mono, Hack and Inconsolata.
" Operator Mono can be found here: http://www.typography.com/fonts/operator/overview/
" Hack can be found here: http://sourcefoundry.org/hack/
" Inconsolata can be found here: http://levien.com/type/myfonts/inconsolata.html
set guifont=OperatorMonoForPowerline-Book:h20

" }}}
" Convenience mappings {{{

" Split line (sister to [J]oin lines)
" The normal usage of S is reproducable with cc which is the same amount of keystrokes.
nnoremap S i<cr><esc><right>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Use Python style regular expressions instead of vim's style.
" nnoremap / /\v
" vnoremap / /\v

" Bubble single lines
" http://vimcasts.org/episodes/bubbling-text/
" Due to OS X keybinding of the C-Up key, I chose to remap to C-k and so forth.
nmap <C-k> ddkP
nmap <C-j> ddp

" Bubble multiple lines
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" switch to last file
nnoremap <leader><leader> <c-^>

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Only show cursorline in the current window and in normal mode.
augroup cline
  autocmd!

  autocmd WinLeave,InsertEnter * set nocursorline
  autocmd WinEnter,InsertLeave * set cursorline
augroup END

" Indent Guides
let g:indentguides_state = 0
function! IndentGuides() " {{{
  if g:indentguides_state
    let g:indentguides_state = 0
    2match None
  else
    let g:indentguides_state = 1
    execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
  endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
" Toggles indent guides
nnoremap <leader>I :call IndentGuides()<cr>

" }}}
" Folding {{{

nnoremap <leader>z zMzvzz

" }}}
" On Save {{{

" On save strip trailing whitespace and convert line endings to Unix format
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
augroup prewrites
  autocmd!

  autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

" Source the .vimrc file after saving it.  This way, you don't have to reload Vim to see the changes.
augroup myvimrchooks
  autocmd!

  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" }}}
" Version Control {{{

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" Whitespace {{{

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>

" Super retab: http://vim.wikia.com/wiki/Super_retab
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" }}}
" Casing {{{

" Lowercases all HTML tags: http://vim.wikia.com/wiki/Changing_case_with_regular_expressions
:command! LowerCaseHTML :%s/<\/\=\(\w\+\)\>/\L&/g

" Lowercases an entire file
:command! LowerCaseFile :%s/.*/\L&/g

" Uppercases an entire file (I can't think of when this would ever be useful)
:command! UpperCaseFile :%s/.*/\U&/g

" }}}
" Quick Editing {{{

nnoremap <leader>ed :vsplit ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>em :vsplit ~/.muttrc<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" }}}
" Kill Arrow Keys {{{

" New Vim users will want the following lines to teach them to do things right
" For training only.  Remove when need be.  Honestly though, I'll probably never
" re-enable this.
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

" }}}
" Tab Completion {{{

" Use TAB to complete when typing words, else inserts TABs as usual.
" Uses dictionary and source files to find matching words to complete.
" There's probably a cool vim plugin that does this, but this is a blunt and
" simple too and it works for me.

" See help completion for source,
" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
" Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"

" }}}
" Rename File {{{

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <leader>rn :call RenameFile()<cr>

" }}}
" Trailing whitespace {{{

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  autocmd!

  autocmd InsertEnter * :set listchars-=trail:⌴
  autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
  autocmd!

  autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
augroup END

" }}}
" Backups {{{

set backup                        " enable backups
set noswapfile                    " it's 2016, Vim.
" The extra slash on the end saves files under the name of their full path
" with the / character replaced with a %.
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" }}}
" File & Filetype specific configurations {{{

" Filetype specific configurations {{{

" bash {{{

augroup ft_sh
  autocmd!

  " Lets me fold functions in bash
  autocmd FileType sh setlocal foldmethod=marker
  autocmd Filetype sh setlocal foldmarker={,}
augroup END

" }}}
" conf {{{

augroup ft_conf
  autocmd!

  au BufNewFile,BufRead *.conf set filetype=conf
  autocmd FileType conf setlocal foldmethod=marker
  autocmd Filetype conf setlocal foldmarker={{{,}}}
augroup END

" }}}
" crontab {{{

autocmd filetype crontab setlocal nobackup nowritebackup

" }}}
" css {{{

" Sorts CSS properties.  Most useful command ever.
" See: http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
nnoremap <leader>S :g#\({\n\)\@<=#.,/}/sort <bar> :%s/:\(\S\+;\)/: \1/g<CR>
:command! BeautifyCSS :g#\({\n\)\@<=#.,/}/sort <bar> %s/:\(\S\+;\)/: \1/g

augroup ft_css
  autocmd!

  " TODO: Investigate whether or not we can simply use `foldmethod=syntax`
  " for CSS
  autocmd Filetype css setlocal foldmethod=marker
  autocmd Filetype css setlocal foldmarker={,}
  autocmd Filetype css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd Filetype css setlocal iskeyword+=-

  " Use <leader>S to sort properties.  Turns this:
  "
  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;
  "
  "         ...
  "     }
  "
  " into this:
  "
  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "         ...
  "     }
  autocmd BufNewFile,BufRead *.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  autocmd BufNewFile,BufRead *.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" fish {{{

augroup ft_fish
  autocmd!

  autocmd BufNewFile,BufRead *.fish setlocal filetype=fish
  " Enable folding of block structures in fish.
  autocmd FileType fish setlocal foldmethod=expr
  " Set this to have long lines wrap inside comments.
  autocmd FileType fish setlocal textwidth=80
  autocmd Filetype fish setlocal noexpandtab
  " Set up :make to use fish for syntax checking.
  autocmd FileType fish compiler fish
  autocmd FileType fish setlocal foldmethod=marker
  autocmd FileType fish setlocal foldmarker={{{,}}}

" }}}
" gitcommit {{{

augroup ft_gitcommit
  autocmd!

  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal textwidth=70
augroup END

" }}}
" go {{{

augroup ft_golang
  autocmd!

  au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
augroup END

" }}}
" haml {{{

augroup ft_haml
  autocmd!

  autocmd Filetype haml setlocal foldmethod=syntax
  autocmd Filetype haml setlocal colorcolumn=0
  autocmd BufRead,BufNewFile Capfile setlocal filetype=haml
augroup END

" }}}
" handlebars {{{

augroup ft_handlebars
  autocmd!

  autocmd Filetype html.handlebars setlocal foldmethod=indent
  autocmd BufNewFile,BufRead *.hbs setlocal filetype=html.handlebars
augroup END

" }}}
" javascript {{{

augroup ft_javascript
  autocmd!

  " For Syntastic
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = "./node_modules/eslint/bin/eslint.js"

  autocmd FileType javascript setlocal foldmethod=syntax

  " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  autocmd Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>

  " Set which javascript libraries I use with https://github.com/othree/javascript-libraries-syntax.vim
  let g:used_javascript_libs = 'react,lo-dash,angularjs,jquery,chai'
augroup END

" }}}
" json {{{

augroup ft_json
  autocmd!

  autocmd FileType json setlocal foldmethod=syntax

  " Make JSON not look like ass
  com! FormatJSON %!python -m json.tool
augroup END

" }}}
" mail {{{

augroup ft_mail
  autocmd!


  autocmd FileType mail setlocal fo+=aw " No ugly line breaks in emails http://wcm1.web.rice.edu/mutt-tips.html
  autocmd FileType mail setlocal spell
  autocmd FileType mail setlocal textwidth=0
augroup END

" }}}
" make {{{

augroup ft_make
  autocmd!

  autocmd Filetype make setlocal noexpandtab
  autocmd FileType make setlocal foldmethod=marker
  autocmd Filetype make setlocal foldmarker={{{,}}}
augroup END

" }}}
" markdown {{{

augroup ft_markdown
  autocmd!

  autocmd BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1
  autocmd FileType markdown setlocal textwidth=0
  autocmd FileType markdown setlocal spell

  set formatoptions+=t
augroup END

" }}}
" ruby {{{

augroup ft_ruby
  autocmd!

  autocmd Filetype ruby setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile Capfile setlocal filetype=ruby
augroup END

" Tells Vim to set the syntax for our .irbrc file to Ruby.
autocmd BufNewFile,BufRead .irbrc set syntax=html

" }}}
" scala {{{

augroup ft_scala
  autocmd!

  autocmd Filetype scala setlocal foldmethod=syntax
  autocmd FileType help setlocal textwidth=160

  autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

  " Settings for Ensime http://ensime.org/editors/vim/install/
  " Typechecking after writing
  autocmd BufWritePost *.scala silent :EnTypeCheck
  " Easy Type Inspection
  nnoremap <localleader>t :EnTypeCheck<CR>
  au FileType scala nnoremap <localleader>df :EnDeclarationSplit v<CR>
augroup END

" }}}
" vim {{{

:command! ClearQuickfixList cexpr []
augroup ft_vim
  autocmd!

  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType help setlocal textwidth=80
  autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" xml {{{

augroup ft_xml
  autocmd!

  autocmd FileType xml setlocal foldmethod=indent

  " Use <localleader>f to fold the current tag.
  autocmd FileType xml nnoremap <buffer> <localleader>f Vatzf

  " Indent tag
  autocmd FileType xml nnoremap <buffer> <localleader>= Vat=

  " Source: http://vim.wikia.com/wiki/Pretty-formatting_XML
  function! DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
  endfunction

  command! PrettyXML call DoPrettyXML()
augroup END

" }}}
" yml {{{

augroup ft_yaml
  autocmd!

  autocmd FileType yaml set shiftwidth=2
augroup END

" }}}

" }}}
" File specific configurations {{{

" bash_profile {{{

augroup ft_bash_profile
  autocmd!

  au BufNewFile,BufRead .bash_profile setlocal foldmethod=marker
  au BufNewFile,BufRead .bash_profile setlocal foldmarker={{{,}}}
augroup END

" }}}
" gitconfig {{{

augroup ft_gitconfig
  autocmd!

  autocmd Filetype gitconfig setlocal noexpandtab
  autocmd FileType gitconfig setlocal foldmethod=marker
  autocmd Filetype gitconfig setlocal foldmarker={{{,}}}
augroup END

" }}}
" muttrc {{{

augroup ft_muttrc
  autocmd!

  au BufRead,BufNewFile *.muttrc set filetype=muttrc
  autocmd FileType muttrc setlocal foldmethod=marker
  autocmd Filetype muttrc setlocal foldmarker={{{,}}}
augroup END

" }}}

" }}}

" }}}
" Vim Plugin Configurations {{{

" Airline {{{

" Allows us to get the lovely symbols for Airline in the prompt
let g:airline_powerline_fonts = 1

" }}}
" CtrlP {{{

let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/](bower_components|node_modules|coverage|false|\.build|\.tmp|dist|docs|project|target)$'
 \ }

" Allows indexing of more files
let g:ctrlp_max_depth = 40
let g:ctrlp_match_window = 'results:20'

" Shows the hidden dot files
let g:ctrlp_show_hidden = 0

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" EditorConfig {{{

let g:EditorConfig_max_line_indicator = "none"

" }}}
" Goyo {{{

" Maps Goyo to <leader>g.
map <leader>g :Goyo<CR>

" }}}
" LocalVimrc {{{

let g:localvimrc_ask=0 " Don't ask before loading a vimrc file

" }}}
" NERDTree {{{

" Maps NERDTree to ^n.
map <C-n> :NERDTreeToggle<CR>

let NERDTreeIgnore=['node_modules[[dir]]', 'dist[[dir]]', 'vendor[[dir]]', 'docs[[dir]]', 'junit-reports[[dir]]', 'target[[dir]]', 'project[[dir]]']

" }}}
" vim-javascript {{{

let g:javascript_plugin_jsdoc = 1 " https://github.com/pangloss/vim-javascript#configuration-variables

" }}}

" }}}
