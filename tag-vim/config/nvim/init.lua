-- 0 preamble ------------------------------------------------------ {{{

-- Jesse Atkinson | jesse@jsatk.us | @jsatk | https://jsatk.us
--
-- The following was stolen from @emilyst.  I thought this was clever and
-- educational so I wanted to do the same in my own .vimrc.
--
-- Original text written by her here:
-- https://github.com/emilyst/home/blob/master/.vimrc#L3-L9
--
--     My ".vimrc" contains configures options which are core to Vim and
--     are enumerated by the `:options` command. It groups the options
--     into the same sections given by that command and in the same order
--     for reference.
--
--     Occasionally, each section contains other mappings or variable
--     settings relevant to the options adjacent to them.
--
-- It's also worth noting that a lot of options you might expect to be
-- set aren't.  The reason for that is many of the most common and
-- sensible options are set in tpope's vim-sensible, which I use.  So if
-- you're wondering why I don't have `set wildmenu`, etc., in here it's
-- because it's set in vim-sensible.
--
-- Lastly, this is a pure Lua set up for neovim using some (as of this
-- writing) bleeding edge stuff that is definitely in beta.  I maintain
-- a separate ~/.vimrc for plain Vim 8.  If you'd like to learn more
-- about Lua and specifically how to use it with neovim I recommend
-- checking out these two links:
-- https://github.com/nanotee/nvim-lua-guide/#defining-mappings.
-- https://oroques.dev/notes/neovim-init/

-- Setup {{{

-- Shamelessly stolen from Chris Kipp
-- https://github.com/ckipp01/dots/blob/629debe5c2b319765052e1797b197288d4d6ba63/nvim/.config/nvim/init.lua#L1-L19
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local function opt(scope, key, value)
  local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

opt('o', 'shell', 'fish')

-- }}}
-- Plugins {{{

-- All plugins are in ~/.config/nvim/lua/plugins.lua.
-- All individual plugin settings are in
-- ~/.config/nvim/lua/settings/$PLUGIN_NAME.

require 'plugins'

require('settings.galaxyline').setup()
require('settings.compe').setup()

-- }}}

-- }}}
-- 1 important ----------------------------------------------------- {{{

-- A |sentence| has to be followed by two spaces after the '.', '!' or '?'.
-- See: https://stevelosh.com/blog/2012/10/why-i-two-space/#s6-power
vim.o.cpo = vim.o.cpo .. 'J'

-- }}}
-- 2 moving around, searching and patterns ------------------------- {{{

opt('o', 'ignorecase', true) -- Ignore the case, unless...
opt('o', 'smartcase', true)  -- ...there's caps in it.

-- }}}
-- 3 tags ---------------------------------------------------------- {{{

-- }}}
-- 4 displaying text ----------------------------------------------- {{{

opt('o', 'scrolloff', 3)
opt('o', 'linebreak', true)
opt('o', 'breakindent', true)
opt('o', 'showbreak', '↪')
opt('o', 'lazyredraw', true)
opt('o', 'list', true)

-- }}}
-- 5 syntax, highlighting and spelling ----------------------------- {{{

opt('o', 'background', 'dark')

-- Needed to esnure float background doesn't get odd highlighting
-- https://github.com/joshdick/onedark.vim#onedarkset_highlight
-- https://github.com/scalameta/coc-metals/wiki/Commonly-Asked-Questions
cmd [[augroup colorset]]
cmd [[autocmd!]]
cmd [[autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })]]
cmd [[augroup END]]

-- For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
-- Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
-- < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if fn.has('termguicolors') == 1 then
  opt('o', 'termguicolors', true)
end

g['onedark_terminal_italics'] = 1
cmd 'colorscheme onedark'

opt('o', 'synmaxcol', 800)
opt('o', 'hlsearch', true)
opt('o', 'cursorline', true)
opt('o', 'guifont', 'OperatorMonoForPowerline-Book:h18')

-- Stolen from Steve Losh
-- 
-- There are three dictionaries I use for spellchecking:
-- 
--   /usr/share/dict/words
--   Basic stuff.
-- 
--   ~/.vim/custom-dictionary.utf-8.add
--   Custom words (like my name).  This is in my (version-controlled) dotfiles.
-- 
--   ~/.vim-local-dictionary.utf-8.add
--   More custom words.  This is *not* version controlled, so I can stick
--   work stuff in here without leaking internal names and shit.
-- 
-- I also remap zG to add to the local dict (vanilla zG is useless anyway).
opt('o', 'spellfile', fn.expand('~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add'))
map('n', 'zG', '2zg')

cmd [[hi! Comment gui=italic]]

-- Highlight VCS conflict markers
fn.matchadd('ErrorMsg', '^\\(<\\|=\\|>\\)\\{7\\}\\([^=].\\+\\)\\?$')

-- }}}
-- 6 multiple windows ---------------------------------------------- {{{

opt('o', 'hidden', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)

-- }}}
-- 7 multiple tab pages -------------------------------------------- {{{

-- }}}
-- 8 terminal ------------------------------------------------------ {{{

opt('o', 'title', true)

-- }}}
-- 9 using the mouse ----------------------------------------------- {{{

if fn.has('mouse') == 1 then
  opt('o', 'mouse', 'a')
end

-- }}}
-- 10 printing ----------------------------------------------------- {{{

-- }}}
-- 11 messages and info -------------------------------------------- {{{

opt('o', 'showcmd', true)
opt('o', 'showmode', true)

-- Avoid showing message extra message when using completion
-- Ensure autocmd works for Filetype
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'

-- }}}
-- 12 selecting text ----------------------------------------------- {{{

-- }}}
-- 13 editing text ------------------------------------------------- {{{

opt('o', 'textwidth', 0)
opt('o', 'wrapmargin', 0)
opt('o', 'dictionary', '/usr/share/dict/words')
opt('o', 'showmatch', true)
opt('o', 'nrformats', 'octal,hex,alpha') -- Increment alpha strings with Vim.

-- As of this writing (2021-02-13) for reasons unknown vim.o.undofile
-- isn't a thing so we can't set it
cmd('set undofile')
-- The extra slash on the end saves files under the name of their full path
-- with the / character replaced with a %.
opt('o', 'undodir', fn.expand('~/.config/nvim/tmp/undo//'))
-- Make the undo directory automatically if it doesn't already exist.
if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, "p") end

-- Set completeopt to have a better completion experience
opt('o', 'completeopt', 'menuone,noinsert,noselect')

-- }}}
-- 14 tabs and indenting ------------------------------------------- {{{

opt('o', 'shiftwidth', 2)
opt('o', 'softtabstop', 2)
opt('o', 'shiftround', true)
opt('o', 'expandtab', true)

-- }}}
-- 15 folding ------------------------------------------------------ {{{

opt('o', 'foldenable', true)
opt('o', 'foldlevelstart', 0)

map('n', '<Space>', 'za')
map('v', '<Space>', 'za')
map('n', 'z0', 'zcz0')

-- TODO: Convert this to lua.
vim.api.nvim_exec(
[[
" This function defines what folded text looks like.
function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart(' ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
]],
false
)

cmd('set foldmethod=expr')
cmd('set foldexpr=nvim_treesitter#foldexpr()')

-- }}}
-- 16 diff mode ---------------------------------------------------- {{{

-- }}}
-- 17 mapping ------------------------------------------------------ {{{

-- This section contains the few options that are under `17 mapping` in
-- `:options` as well as all of my custom remappings that don't sensibily
-- fit in another section.  For example, the folding remappings I have
-- live  under `15 folding` but my `S` mapping for splitting lines lives
-- here.

opt('o', 'timeoutlen', 500)

g['mapleader'] = ','
g['maplocalleader'] = ','
-- Do not show stupid q: window
map('', 'q:', ':q')
-- I don't know how to use ex mode and it scares me.
map('', 'Q', '<Nop>')
-- Split line (sister to [J]oin lines)
map('n', 'S', 'i<cr><esc><right>')
-- switch to last file
map('n', '<leader><leader>', '<c-^>')
-- redraw the buffer
map('n', '<leader>r', ':syntax sync fromstart<cr>:redraw!<cr>')
-- Don't jump-to-next when I use * to search for what's under cursor.
map('n', '*', '*<c-o>')
-- <C-l> redraws the screen and removes any search highlighting.
map('n', '<c-l>', ':nohlsearch<cr><c-l>')

-- Keep search matches in the middle of the window.
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- TODO: Get this working. Clean trailing whitespace.   
map('n', '<leader><space>', "mz:%s/s+$//<cr>:let @/=''<cr>`z")

-- Only show when not in insert mode.
cmd [[augroup trailing]]
cmd [[autocmd!]]
cmd [[autocmd InsertEnter * :set listchars-=trail:⌴]]
cmd [[autocmd InsertLeave * :set listchars+=trail:⌴]]
cmd [[augroup END]]

-- My garbage brain can't ever remember digraph codes.
map('i', '<c-k><c-k>', '<esc>:help digraph-table<cr>')

-- Only show cursorline in the current window and in normal mode.
cmd [[augroup cline]]
cmd [[autocmd!]]
cmd [[autocmd WinLeave,InsertEnter * set nocursorline]]
cmd [[autocmd WinEnter,InsertLeave * set cursorline]]
cmd [[augroup END]]

-- Keep the cursor in place while joining lines
map('n', 'J', 'mzJ`z')

-- TODO: Toggle quickfix
-- function! QuickFixIsOpen()
--   let l:result = filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
--   return !empty(l:result)
-- endfunction
-- nnoremap yoq :<C-R>=QuickFixIsOpen() ? "cclose" : "copen"<CR><CR>

-- Quick editing some common dotfiles.
map('n', '<leader>ed', ':vsplit ~/.vim/custom-dictionary.utf-8.add<cr>')
map('n', '<leader>ef', ':vsplit ~/.config/fish/config.fish<cr>')
map('n', '<leader>eg', ':vsplit ~/.gitconfig<cr>')
map('n', '<leader>em', ':vsplit ~/.muttrc<cr>')
map('n', '<leader>ep', ':vsplit ~/Developer/jsatk.us/content/dotplan.md<cr>')
map('n', '<leader>et', ':vsplit ~/.tmux.conf<cr>')
map('n', '<leader>ev', ':vsplit ~/.config/nvim/init.lua<cr>')

-- }}}
-- 18 reading and writing files ------------------------------------ {{{

opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('o', 'autowrite', true)
opt('o', 'backupdir', fn.expand('~/.config/nvim/tmp/backup//'))

-- Make the backup directory automatically if it doesn't already exist.
if fn.isdirectory(vim.o.backupdir) == 0 then fn.mkdir(vim.o.backupdir, "p") end

-- }}}
-- 19 the swap file ------------------------------------------------ {{{

opt('o', 'directory', fn.expand('~/.config/nvim/tmp/swap//'))
-- As of this writing (2021-02-13) for reasons unknown vim.o.noswapfile
-- isn't a thing in Lua + Neovim so we can't set it.
cmd('set noswapfile')

-- Make the swap directory automatically if it doesn't already exist.
if fn.isdirectory(vim.o.directory) == 0 then fn.mkdir(vim.o.directory, "p") end

-- }}}
-- 20 command line editing ----------------------------------------- {{{

opt('o', 'wildmode', 'list:longest')

-- }}}
-- 21 executing external commands ---------------------------------- {{{

-- }}}
-- 22 running make and jumping to errors --------------------------- {{{

-- }}}
-- 23 language specific -------------------------------------------- {{{

-- }}}
-- 24 multi-byte characters ---------------------------------------- {{{

-- > When on all Unicode emoji characters are considered to be full
-- > width.
-- 
-- Emoji of different byte lengths render funky in Vim without this
-- turned off.
opt('o', 'emo', false)

-- }}}
-- 25 various ------------------------------------------------------ {{{

opt('o', 'gdefault', true)

-- The following settings aren't under `:options` at all, so it made the
-- most sense to throw them in the `25 various` junk-drawer.
opt('o', 'ttyfast', true)
opt('o', 'startofline', false)
opt('o', 't_Co', '256')

-- Make sure Vim returns to the same line when you reopen a file.
cmd [[augroup line_return]]
cmd [[autocmd!]]
cmd [[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]]
cmd [[augroup END]]

-- }}}
-- 99 plugin configurations ---------------------------------------- {{{

-- Dashboard {{{

g['dashboard_default_executive'] = 'telescope'
g['dashboard_custom_header'] = {
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

-- }}}
-- Dispatch {{{

-- Why am I doing this?  See link below.
-- See: https://github.com/tpope/vim-dispatch/issues/222#issuecomment-493273080
opt('o', 'shellpipe', '2>&1|tee')

map('n', '<F9>', ':Dispatch<CR>')

-- }}}
-- EasyAlign {{{

-- Start interactive EasyAlign in visual mode (e.g. vipga).
-- Note: Using |:*noremap| will not work with <Plug> mappings.
cmd [[xmap ga <Plug>(EasyAlign)]]

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- Intentionally not using `nnoremap`.
-- Note: Using |:*noremap| will not work with <Plug> mappings.
cmd [[nmap ga <Plug>(EasyAlign)]]

-- }}}
-- Gundo {{{

map('n', '<F5>', ':GundoToggle<CR>')

-- }}}
-- Metals {{{

-- Mostly stolen from Chris Kipp.
-- See: https://github.com/scalameta/nvim-metals/discussions/39#discussion-82302

-- LSP

-- Default in vim for K is to open the man/help of what your cursor is
-- on.  This keeps that muscle memory alive but instead leans on the LSP
-- to provide the info.
-- TODO: Rewrite this so if LSP is active it uses hover otherwise does
--       the default action.
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- Remap keys for gotos
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {nowait = true})
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {nowait = true})
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

-- Remap for do codeAction of current line
map('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- Used to expand decorations in worksheets
map('n', '<leader>ws', '<cmd>lua require"metals".worksheet_hover()<CR>')

map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Use `[g` and `]g` for navigate diagnostics
map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>')
map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>')

-- Remap for rename current word
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Show all diagnostics
map('n', '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>')
-- Show only buffer diagnostics
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

-- I use ^n & ^p to navigate up-and-down menus.
-- Using <Tab> to navigate menus is for zoomers.
-- In a menu when I press <CR> autocomplete it for me.
map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})

----------------------------------
-- COMMANDS ----------------------
----------------------------------
-- LSP
cmd [[augroup lsp]]
cmd [[autocmd!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
cmd [[augroup END]]

-- Need for symbol highlights to work correctly
cmd [[hi! link LspReferenceText CursorColumn]]
cmd [[hi! link LspReferenceRead CursorColumn]]
cmd [[hi! link LspReferenceWrite CursorColumn]]
----------------------------------
-- LSP Setup ---------------------
----------------------------------
metals_config = require'metals'.bare_config

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl'}
}

-- Example of how to ovewrite a handler
metals_config.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = {prefix = ''}})

-- Example if you are including snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

metals_config.capabilities = capabilities

-- Exhaustive match support, etc.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
metals_config.capabilities = capabilities

metals_config.init_options.statusBarProvider = 'on'

-- }}}
-- Projectionist {{{

g.projectionist_heuristics = {
  ["*.markdown|*.md"] = {
    ["*.md"] = { dispatch = "open -a 'Marked 2.app' {file}" },
    ["*.markdown"] = { dispatch = "open -a 'Marked 2.app' {file}" }
  },
  ["package.json"] = {
    ["README.md"] = { type = "doc" },
    ["*"] = {
      console = "node",
      make = "npm",
      start = "npm start"
    },
    ["lib/*.js"] = {
      type = "src",
      alternate = "test/{}.js"
    },
    ["test/*.js"] = {
      type = "test",
      alternate = "lib/{}.js",
      dispatch = "yarn test {}"
    },
    ["package.json"] = { type = "package" }
  },
  ["Cargo.toml"] = {
    ["README.md"] = { type = "doc" },
    ["src/*.rs"] = {
      type = "src",
      alternate = "tests/{}.rs"
    },
    ["tests/*.rs"] = {
      type = "test",
      alternate = "src/{}.rs",
      dispatch = "cargo test {}"
    },
    ["benchmarks/*.rs"] = { type = "bench" },
    ["Cargo.toml"] = { type = "config" }
  },
  ["build.sbt"] = {
    ["README.md"] = { type = "doc" },
    ["*"] = {
      console = "bloop console",
      make = "bloop compile",
      start = "bloop run"
    },
    ["src/main/scala/*.scala"] = {
      alternate = "src/test/scala/{}Spec.scala",
      type = "src"
    },
    ["src/test/scala/*Spec.scala"] = {
      alternate = "src/main/scala/{}.scala",
      type = "test",
      dispatch = "bloop test --no-color -o {dot}Spec"
    },
    ["build.sbt"] = { type = "config" },
    ["*.sbt"] = { type = "config" },
  }
}

-- }}}
-- Rhubarb {{{

g['github_enterprise_urls'] = {"https://code.corp.creditkarma.com"}

-- }}}
-- Telescope {{{

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')

-- }}}
-- Treesitter {{{

require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {enable = true}
}

-- }}}
-- Vista {{{

g['vista_icon_indent'] = {"╰─▸ ", "├─▸ "}
g['vista_default_executive'] = 'nvim_lsp'
g['vista#renderer#enable_icon'] = 1

map('n', '<leader>t', ':<C-u>Vista!!<CR>')

-- }}}

-- }}}
-- vim: set foldmethod=marker foldlevel=0 textwidth=72:
