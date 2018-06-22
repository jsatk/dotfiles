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
" Special thanks to Steve Losh, Tim Pope, and Jess Frazelle who I have stolen *so* much from.

" }}}
" Vim Plug {{{
" https://github.com/junegunn/vim-plug

" Vim needs a more POSIX compatible shell than fish for certain functionality
" to work, such as :%!, compressed help pages and many third-party addons.  If
" you use fish as your login shell or launch Vim from fish, you need to set
" shell to something else in your ~/.vimrc.
" Seriously... god dammit Vim.
if &shell =~# 'fish$'
  set shell=sh
endif

call plug#begin()

" Our Vim plugins!

Plug 'ctrlpvim/ctrlp.vim'               " True fuzzy find.  The greatest thing ever for us lazy folk.
Plug 'dag/vim-fish'                     " Fish Shell syntax highlighting for vim.
Plug 'derekwyatt/vim-sbt'               " Adds very basic support for SBT.
Plug 'derekwyatt/vim-scala'             " Makes working with Scala easier.
Plug 'editorconfig/editorconfig-vim'    " Maintain consistent coding styles between different editors and IDEs.
Plug 'fatih/vim-go'                     " Makes working with Go easier.
Plug 'flazz/vim-colorschemes'           " All the colorschemes money can buy.
Plug 'junegunn/goyo.vim'                " Makes working with plain text/markdown nicer.
Plug 'junegunn/vim-easy-align'          " Aligns multiple lines on any given point.  Useful for assignments.
Plug 'junegunn/vim-github-dashboard'    " Browse GitHub events (user dashboard, user/repo activity) in Vim.
Plug 'maralla/completor.vim'            " Autocompletion.  Requires Vim 8.
Plug 'mattn/gist-vim'                   " Send text straight to a gist.
Plug 'morhetz/gruvbox'                  " Cool colorscheme
Plug 'mustache/vim-mustache-handlebars' " Mustache & Handlebars support.
Plug 'mxw/vim-jsx'                      " Syntax highlighting for React's JSX.
Plug 'pangloss/vim-javascript'          " Adds some javascript nicities.
Plug 'Raimondi/delimitMate'             " Provides auto closing of parens, braces, and brackets in insert mode.
Plug 'rizzatti/dash.vim'                " Easy look up of docs via Dash.app
Plug 'rust-lang/rust.vim'               " Makes working with rust easier.
Plug 'scrooloose/nerdtree'              " A vim explorer replacement.  Much nicer and easier to use.
Plug 'solarnz/arcanist.vim'             " Syntax highlighting for Phabricator/Arc files.
Plug 'tmhedberg/SimpylFold'             " Code folding for Python
Plug 'tpope/vim-abolish'                " Better find and replace.
Plug 'tpope/vim-commentary'             " Easier comment support in vim.  Comment out blocks with gcc.
Plug 'tpope/vim-db'                     " For working with batabases.
Plug 'tpope/vim-dispatch'               " Terminal in your vim.  Works best with tmux.
Plug 'tpope/vim-endwise'                " Auto-adds end statements to languages such as Ruby and Vimscript
Plug 'tpope/vim-fugitive'               " Git support in vim.  Incredible handy for merge conflicts.
Plug 'tpope/vim-rails'                  " Makes working with Rails more better.
Plug 'tpope/vim-rhubarb'                " Expands upon Fugitive.  Allows you to open files in github.
Plug 'tpope/vim-sensible'               " A universal set of defaults that (hopefully) everyone can agree on.
Plug 'tpope/vim-surround'               " Makes surrounding stuff with characters easier.
Plug 'tpope/vim-unimpaired'             " Provides some nice key mappings.
Plug 'vim-airline/vim-airline'          " Adds a gorgeous toolbar with useful info to bottom of vim.
Plug 'vim-airline/vim-airline-themes'   " Airline themes.  Self explanatory.
Plug 'vim-scripts/LargeFile'            " Add support for working with big-ass files.
Plug 'w0rp/ale'                         " Adds error checking while writing or on save in vim.

call plug#end()

" }}}
" Basic Options {{{

" Prevents some security exploits having to do with modelines in files.
set modelines=0

" Enhance command-line completion
set wildmenu

" Auto-completion menu
set wildmode=list:longest

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

" Make tabs as wide as two spaces
set shiftwidth=2
set softtabstop=2

" Highlight current line
set cursorline

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

" Goddammit vim.  Make fucking backspace/delete on macOS work correctly.
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

" wrap lines without changing the amount of indent.
set breakindent

" Turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0
set wrapmargin=0

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Tenths of a second to show the matching paren, when 'showmatch' is set.
set matchtime=3

" Add the g flag to search/replace by default
set gdefault

" Remaps leader key to an easier key
let mapleader = ","

" I don't know how to use ex mode and it scares me.
noremap Q <Nop>

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
noremap q: :q

" Hides buffers instead of closing them.
set hidden

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
" gruvbox comes from https://github.com/morhetz/gruvbox
colorscheme lucius

" Sets the ColorColumn to a sensible color.
highlight ColorColumn ctermbg=237 guibg=#3a3a3a

" Sets comments to italics
" Reference: https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/
" I realize setting t_ZH and t_ZR directly is probably 'bad' to more advanced
" vim folks.  Practicality beats purity. ¯\_(ツ)_/¯
" Check out my blog post about this here: https://jsatk.us/vim-tmux-italics-and-insanity-9a96b69eeca6#.q0ygz6too
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic

" Set font type and size.  Depends on the resolution.  Larger screens, prefer h20
" My two favorite programming typefaces are Operator Mono, Hack and Inconsolata.
" Operator Mono can be found here: http://www.typography.com/fonts/operator/overview/
" Hack can be found here: http://sourcefoundry.org/hack/
" Inconsolata can be found here: http://levien.com/type/myfonts/inconsolata.html
set guifont=OperatorMonoForPowerline-Book:h18

" }}}
" Convenience Mappings {{{

" Split line (sister to [J]oin lines)
" The normal usage of S is reproducable with cc which is the same amount of keystrokes.
nnoremap S i<cr><esc><right>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" switch to last file
nnoremap <leader><leader> <c-^>

" redraw the buffer.  This is convenient for when you resize or change
" font-size and the buffer looks all wonky.
nnoremap <leader>r :redraw!<cr>

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
function! IndentGuides() abort " {{{
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

" Quick Editing {{{

nnoremap <leader>ed :vsplit ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>em :vsplit ~/.muttrc<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" }}}

" }}}
" Folding {{{

" Fold everything except what you're cursor is in
nnoremap <leader>z zMzvzz

" }}}
" On Save {{{

" On save strip trailing whitespace and convert line endings to Unix format
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
augroup prewrites
  autocmd!

  autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

" }}}
" Version Control {{{

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
"  Tags {{{

" Stolen from: https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim#L86

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
" Default ctags that comes with macOS is hot garbage.  `brew install ctags`
" There's probably a sexy regular expression to do what I'm doing with all the
" multiple exclude statements, but I don't really care.  I'd rather have this be
" verbose and stupidly readable and editable.
command! MakeTags !ctags --recurse
  \ --exclude=".build"
  \ --exclude=".bundle"
  \ --exclude=".git"
  \ --exclude=".tmp"
  \ --exclude="bower_components"
  \ --exclude="coverage"
  \ --exclude="dist"
  \ --exclude="docs"
  \ --exclude="genfiles"
  \ --exclude="log"
  \ --exclude="node_modules"
  \ --exclude="project"
  \ --exclude="target"
  \ --exclude="third_party"
  \ --exclude="vendor"
  \ .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" }}}
" Rename File {{{

" Rename current file
function! RenameFile() abort
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

noremap <leader>rn :call RenameFile()<cr>

" }}}
" Trailing Whitespace {{{

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  autocmd!

  autocmd InsertEnter * :set listchars-=trail:⌴
  autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  autocmd!

  autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
augroup END

" }}}
" Backups {{{

set undofile                      " Maintain undo history between sessions
set backup                        " enable backups
set noswapfile                    " it's 2018, Vim.
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
" File & Filetype Specific Configurations {{{

" Filetype Specific Configurations {{{

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

augroup ft_crontab
  autocmd!

  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

" }}}
" css {{{

" Sorts CSS properties.
" See: http://stackoverflow.com/questions/3050797/how-to-alphabetize-a-css-file-in-vim
nnoremap <leader>S :g#\({\n\)\@<=#.,/}/sort <bar> :%s/:\(\S\+;\)/: \1/g<CR>
:command! BeautifyCSS :g#\({\n\)\@<=#.,/}/sort <bar> %s/:\(\S\+;\)/: \1/g

augroup ft_css
  autocmd!

  autocmd Filetype css setlocal foldmethod=syntax
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
  autocmd BufRead,BufNewFile gitcommit setlocal textwidth=70
augroup END

" }}}
" groovy {{{
augroup ft_sh
  autocmd!

  " Lets me fold blocks in Jenkins files
  autocmd FileType groovy setlocal foldmethod=marker
  autocmd Filetype groovy setlocal foldmarker={,}
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
" html {{{

augroup ft_html
  autocmd!

  autocmd Filetype html setlocal foldmethod=indent
  autocmd Filetype htmldjango setlocal foldmethod=indent
augroup END

" }}}
" javascript {{{

augroup ft_javascript
  autocmd!

  " Auto-fixing

  " :ALEFix will try and fix your JS code with ESLint.
  let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \}

  " Set this variable to 1 to fix files when you save them.
  let g:ale_fix_on_save = 1

  " Linting

  " Asynchronous Lint Engine (ALE)
  " Limit linters used for JavaScript.
  let g:ale_linters = {
  \  'javascript': ['flow'],
  \}
  highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
  highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
  let g:ale_sign_error = '🔥' " could use emoji
  let g:ale_sign_warning = '⚠️' " could use emoji
  let g:ale_statusline_format = ['X %d', '? %d', '']
  " %linter% is the name of the linter that provided the message
  " %s is the error or warning message
  let g:ale_echo_msg_format = '%linter% says %s'

  " Enable completion where available.
  let g:ale_completion_enabled = 1

  autocmd FileType javascript setlocal foldmethod=syntax

  " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  autocmd Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
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
" python {{{

augroup ft_python
  autocmd!

  " Note: `foldmethod` is set by plugin SimpylFold

  " Ignore compiled python
  set wildignore=*.pyc
  let g:netrw_list_hide= '.*\.pyc$'
augroup END

" }}}
" ruby {{{

augroup ft_ruby
  autocmd!

  " Tells Vim to set the syntax for our .irbrc file to Ruby.
  autocmd BufNewFile,BufRead .irbrc set syntax=html
  autocmd Filetype ruby setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile Capfile setlocal filetype=ruby
augroup END

" }}}
" scala {{{

augroup ft_scala
  autocmd!

  autocmd Filetype scala setlocal foldmethod=syntax

  autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab
augroup END

" }}}
" vim {{{

:command! ClearQuickfixList cexpr []
augroup ft_vim
  autocmd!

  " Make vim resize on host window resize.  Great for increaseing/decreasing
  " font or when you disconnect from your external monitor.
  autocmd VimResized * wincmd =
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
  function! DoPrettyXML() abort
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
" File Specific Configurations {{{

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
" Completor {{{

set dictionary="/usr/dict/words"

" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()

" Binary for javascript completion
let g:completor_node_binary = '~/n/bin/node'
" Binary for Python completion
let g:completor_python_binary = '~/.virtualenv/khan27/bin/python'
" Binary for Rust completion
let g:completor_racer_binary = '~/.cargo/bin/racer'

" }}}
" CtrlP {{{

let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/](bower_components|node_modules|coverage|false|\.build|\.tmp|dist|docs|project|target|genfiles|kake|third_party|genfiles)$'
 \ }

" Allows indexing of more files
let g:ctrlp_max_depth = 40
let g:ctrlp_match_window = 'results:20'

" Shows the hidden dot files
let g:ctrlp_show_hidden = 0

" Only search stuff tracked by git.
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" Intentionally not using `nnoremap`
nmap ga <Plug>(EasyAlign)

" }}}
" EditorConfig {{{

let g:EditorConfig_max_line_indicator = "none"

" }}}
" Github Dashboard {{{

let g:github_dashboard = { 'username': 'jsatk', 'password': $VIMGHDTOKEN }

" }}}
" Goyo {{{

" Maps Goyo to <leader>g.
noremap <leader>g :Goyo<CR>

" }}}
" NERDTree {{{

" Maps NERDTree to ^n.
noremap <C-n> :NERDTreeToggle<CR>

let NERDTreeIgnore = ['node_modules[[dir]]', 'dist[[dir]]', 'target[[dir]]', 'project[[dir]]', 'coverage[[dir]]']

" }}}
" vim-javascript {{{

let g:javascript_plugin_jsdoc = 1 " https://github.com/pangloss/vim-javascript#configuration-variables

" }}}

" }}}
