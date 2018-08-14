"  __   __   __     __    __     ______     ______
" /\ \ / /  /\ \   /\ "-./  \   /\  == \   /\  ___\
" \ \ \'/   \ \ \  \ \ \-./\ \  \ \  __<   \ \ \____
"  \ \__|    \ \_\  \ \_\ \ \_\  \ \_\ \_\  \ \_____\
"   \/_/      \/_/   \/_/  \/_/   \/_/ /_/   \/_____/

" Preamble ---------------------------------------------------------------- {{{

" Author:   Jesse Atkinson
" Email:    jesse@jsatk.us
" Source:   https://github.com/jsatk/dotfiles/blob/master/vimrc
" Twitter:  @jsatk
" Special thanks to Steve Losh, Tim Pope, & Jess Frazelle who I have stolen
" *so* much from.

" }}}
" Vim Plugins ------------------------------------------------------------- {{{
"
" I'm using minpac to manage my Vim plugins which leverages Vim 8's packages
" feature.  https://github.com/k-takata/minpac
"
" Vim needs a more POSIX compatible shell than fish for certain functionality
" to work, such as :%!, compressed help pages and many third-party addons.  If
" you use fish as your login shell or launch Vim from fish, you need to set
" shell to something else in your ~/.vimrc.
" Seriously... god dammit Vim.
if &shell =~# 'fish$'
  set shell=sh
endif

packadd minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('dag/vim-fish')                     " Fish Shell syntax highlighting for vim.
call minpac#add('derekwyatt/vim-sbt')               " Adds very basic support for SBT.
call minpac#add('derekwyatt/vim-scala')             " Makes working with Scala easier.
call minpac#add('editorconfig/editorconfig-vim')    " Maintain consistent coding styles between different editors and IDEs.
call minpac#add('jsatk/vim-colorschemes')           " All the colorschemes money can buy.
call minpac#add('junegunn/goyo.vim')                " Makes working with plain text/markdown nicer.
call minpac#add('junegunn/vim-easy-align')          " Aligns multiple lines on any given point.  Useful for assignments.
call minpac#add('junegunn/fzf.vim')                 " Niceties for working with FZF.
call minpac#add('maralla/completor.vim')            " Autocompletion.  Requires Vim 8.
call minpac#add('mxw/vim-jsx')                      " Syntax highlighting for React's JSX.
call minpac#add('pangloss/vim-javascript')          " Adds some javascript nicities.
call minpac#add('rizzatti/dash.vim')                " Easy look up of docs via Dash.app
call minpac#add('rust-lang/rust.vim')               " Makes working with rust easier.
call minpac#add('solarnz/arcanist.vim')             " Syntax highlighting for Phabricator/Arc files.
call minpac#add('tmhedberg/SimpylFold')             " Code folding for Python
call minpac#add('tpope/vim-abolish')                " Better find and replace.
call minpac#add('tpope/vim-commentary')             " Easier comment support in vim.  Comment out blocks with gcc.
call minpac#add('tpope/vim-db')                     " For working with databases.
call minpac#add('tpope/vim-dispatch')               " Terminal in your vim.  Works best with tmux.
call minpac#add('tpope/vim-endwise')                " Auto-adds end statements to languages such as Ruby and Vimscript
call minpac#add('tpope/vim-fugitive')               " Git support in vim.  Incredible handy for merge conflicts.
call minpac#add('tpope/vim-rhubarb')                " Expands upon Fugitive.  Allows you to open files in github.
call minpac#add('tpope/vim-sensible')               " A universal set of defaults that (hopefully) everyone can agree on.
call minpac#add('tpope/vim-surround')               " Makes surrounding stuff with characters easier.
call minpac#add('tpope/vim-unimpaired')             " Provides some nice key mappings.
call minpac#add('tpope/vim-vinegar')                " Provides some niceties for netrw.
call minpac#add('udalov/kotlin-vim')                " Adds syntax highlighting for Kotlin.
call minpac#add('vim-airline/vim-airline')          " Adds a gorgeous toolbar with useful info to bottom of vim.
call minpac#add('vim-airline/vim-airline-themes')   " Airline themes.  Self explanatory.
call minpac#add('vim-scripts/LargeFile')            " Add support for working with big-ass files.
call minpac#add('w0rp/ale')                         " Adds error checking while writing or on save in vim.

" Load the plugins right now.
packloadall

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" }}}
" Basic Options ----------------------------------------------------------- {{{

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

" Hides buffers instead of closing them.
set hidden

" Allows for project-specific vimrc files
set exrc

" }}}
" Spelling ---------------------------------------------------------------- {{{

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
" Look & Feel ------------------------------------------------------------- {{{

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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" Convenience Mappings ---------------------------------------------------- {{{

" Remaps leader key to an easier key
let mapleader = ","

" Do not show stupid q: window
noremap q: :q

" My garbage brain can't ever remember digraph codes
inoremap <c-k><c-k> <esc>:help digraph-table<cr>

" I don't know how to use ex mode and it scares me.
noremap Q <Nop>

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
" Folding ----------------------------------------------------------------- {{{

" Enable code folding
set foldenable
set foldlevelstart=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a bit (25 lines) down from the top of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
function! FocusLine()
    let oldscrolloff = &scrolloff
    set scrolloff=0
    execute "keepjumps normal! mzzMzvzt25\<c-y>`z:Pulse\<cr>"
    let &scrolloff = oldscrolloff
endfunction
nnoremap <leader>z :call FocusLine()<cr>

" This function defines what folded text looks like.
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

" }}}
" Tags -------------------------------------------------------------------- {{{

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
" Rename File ------------------------------------------------------------- {{{

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
" Trailing Whitespace ----------------------------------------------------- {{{

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  autocmd!

  autocmd InsertEnter * :set listchars-=trail:⌴
  autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Line Return ------------------------------------------------------------- {{{

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  autocmd!

  autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
augroup END

" }}}
" Backups ----------------------------------------------------------------- {{{

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
" File & Filetype Specific Configurations --------------------------------- {{{

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
  " Set this to have long lines wrap inside comments.
  autocmd FileType fish setlocal textwidth=80
  autocmd Filetype fish setlocal noexpandtab
  autocmd Filetype fish setlocal shiftwidth=8
  " Set up :make to use fish for syntax checking.
  autocmd FileType fish compiler fish
  autocmd FileType fish setlocal foldmethod=marker
  autocmd FileType fish setlocal foldmarker={{{,}}}

" }}}
" gitcommit {{{

augroup ft_gitcommit
  autocmd!

  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd BufRead,BufNewFile gitcommit setlocal textwidth=72
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
  autocmd Filetype make setlocal shiftwidth=8
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

  autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2
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

  autocmd FileType gitconfig setlocal textwidth=80
  autocmd Filetype gitconfig setlocal noexpandtab
  autocmd Filetype gitconfig setlocal shiftwidth=8
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
" Vim Plugin Configurations ----------------------------------------------- {{{

" Airline {{{

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" For reasons I cannot understand or explain one day the powerline symbols
" just stopped showing up.  The `g:airline_powerline_fonts = 1` stopped
" working.  So I copy & pasted the powerline stuffs from `:help airline` under
" the customization setting, which is what they recommend if airline stops
" showing powerline symbols.
"
" let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" }}}
" Asynchronous Lint Engine (ALE) {{{

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

let g:ale_statusline_format = ['X %d', '? %d', '']

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says: "%severity% %...code...% – %s'

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
" FZF {{{

" Allows us to use FZF in Vim.
set rtp+=/usr/local/opt/fzf
" Maps FZF to <C-p> because using Sublime & Vim's CtrlP plugin for years broke
" my brain.
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <C-p><C-f> :<C-u>Buffers<CR>
" Sets the search command for FZF.  `rg` follows `.gitignore`s rules if a
" `.gitignore` is found.
let $FZF_DEFAULT_COMMAND = 'rg --files'

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
" vim-javascript {{{

let g:javascript_plugin_jsdoc = 1 " https://github.com/pangloss/vim-javascript#configuration-variables

" }}}

" }}}
" Mini-plugins ------------------------------------------------------------ {{{

" Pulse Line {{{

function! s:Pulse()
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction
command! -nargs=0 Pulse call s:Pulse()

" }}}
" Indent Guides {{{

function! IndentGuides() abort
  if g:indentguides_state
    let g:indentguides_state = 0
    2match None
  else
    let g:indentguides_state = 1
    execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
  endif
endfunction

" }}}

" }}}

" To disable unsafe commands in project-specific .vimrc files
set secure
