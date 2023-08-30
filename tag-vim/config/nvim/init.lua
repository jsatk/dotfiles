-- 0  preamble ---------------------------------------------------- {{{1

-- This file groups the options into the same sections given by the
-- `:options` command and in the same order for reference.

vim.opt_global.shell = "fish"

-- I have to set `mapleader` before lazy.nvim so your mappings are correct.
vim.g.mapleader = ","

-- Set up lazy.nvim – my neovim plugin package manager of choice.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- All plugins are defined in the lua/plugins folder.  Each plugin has a
-- corresponding {plugin-name}.lua file.  All keybindings and
-- customizations for that plugin are done in that file.
-- See: https://github.com/folke/lazy.nvim#-structuring-your-plugins
require("lazy").setup("plugins")

-- 1  important --------------------------------------------------- {{{1

-- A |sentence| has to be followed by two spaces after the '.', '!' or '?'.
-- See: https://stevelosh.com/blog/2012/10/why-i-two-space/#s6-power
vim.o.cpo = vim.o.cpo .. "J"

-- 2  moving around, searching and patterns ----------------------- {{{1

vim.opt_global.ignorecase = true -- Ignore the case, unless...
vim.opt_global.smartcase = true -- ...there's caps in it.

-- 3  tags -------------------------------------------------------- {{{1

-- 4  displaying text --------------------------------------------- {{{1

vim.opt_global.scrolloff = 3
vim.opt_global.linebreak = true
vim.opt_global.breakindent = true
vim.opt_global.showbreak = "↪"
vim.opt_global.lazyredraw = true
vim.opt.list = true

-- 5  syntax, highlighting and spelling --------------------------- {{{1

-- NOTE: My colorscheme's setting are defined in the plugins section.

vim.opt_global.background = "dark"
vim.opt_global.termguicolors = true
vim.opt_global.synmaxcol = 800
vim.opt_global.hlsearch = true
vim.opt_global.cursorline = true

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
--
-- Also for some reason lua doesn't set the spellfile correctly when I
-- do it the "lua" way so `cmd` it is.

-- TODO: This isn't working!  Fix!
vim.opt_global.spellfile = {
  vim.fn.expand("~/.vim/custom-dictionary.utf-8.add"),
  vim.fn.expand("~/.vim-local-dictionary.utf-8.add"),
}
vim.keymap.set("n", "zG", "2zg")

vim.cmd([[hi! Comment gui=italic]]) -- No lua equivelent yet.

-- Highlight VCS conflict markers
vim.fn.matchadd("ErrorMsg", "^\\(<\\|=\\|>\\)\\{7\\}\\([^=].\\+\\)\\?$")

-- 6  multiple windows -------------------------------------------- {{{1

vim.opt_global.hidden = true
vim.opt_global.splitbelow = true
vim.opt_global.splitright = true

-- 7  multiple tab pages ------------------------------------------ {{{1

-- 8  terminal ---------------------------------------------------- {{{1

vim.opt_global.title = true

-- 9  using the mouse --------------------------------------------- {{{1

if vim.fn.has("mouse") == 1 then
  vim.opt_global.mouse = "a"
end

-- 10 printing ---------------------------------------------------- {{{1

-- 11 messages and info ------------------------------------------- {{{1

vim.o.showcmd = true
vim.o.showmode = true

-- Avoid showing message extra message when using completion
-- Ensure autocmd works for Filetype
vim.opt.shortmess:remove("F")
vim.opt.shortmess:append("c")

-- 12 selecting text ---------------------------------------------- {{{1

-- 13 editing text ------------------------------------------------ {{{1

vim.opt_global.textwidth = 0
vim.opt_global.wrapmargin = 0
vim.opt_global.dictionary = "/usr/share/dict/words"
vim.opt_global.showmatch = true
vim.opt_global.nrformats = "octal,hex,alpha" -- Increment alpha strings with Vim.
vim.opt_global.undofile = true
-- The extra slash on the end saves files under the name of their full path
-- with the / character replaced with a %.
vim.opt_global.undodir = vim.fn.expand("~/.config/nvim/tmp/undo//")
-- Make the undo directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.undodir) == 0 then
  vim.fn.mkdir(vim.o.undodir, "p")
end

-- Set completeopt to have a better completion experience
vim.opt_global.completeopt = "menuone,noinsert,noselect"

-- 14 tabs and indenting ------------------------------------------ {{{1

vim.opt_global.shiftwidth = 2
vim.opt_global.softtabstop = 2
vim.opt_global.shiftround = true
vim.opt_global.expandtab = true

-- 15 folding ----------------------------------------------------- {{{1

vim.opt_global.foldenable = true

vim.keymap.set("n", "<Space>", "za")
vim.keymap.set("v", "<Space>", "za")
vim.keymap.set("n", "z0", "zcz0")

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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- 16 diff mode --------------------------------------------------- {{{1

-- 17 mapping ----------------------------------------------------- {{{1

-- This section contains the few options that are under `17 mapping` in
-- `:options` as well as all of my custom remappings that don't
-- sensibily fit in another section.  For example, the folding
-- remappings I have live  under `15 folding` but my `S` mapping for
-- splitting lines lives here.

vim.opt_global.timeoutlen = 500

vim.g.maplocalleader = "\\"
-- Do not show stupid q: window
vim.keymap.set("", "q:", ":q")
-- I don't know how to use ex mode and it scares me.
vim.keymap.set("", "Q", "<Nop>")
-- Split line (sister to [J]oin lines)
vim.keymap.set("n", "S", "i<cr><esc><right>")
-- redraw the buffer
vim.keymap.set("n", "<leader>r", ":syntax sync fromstart<cr>:redraw!<cr>")

-- Keep search matches in the middle of the window.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Trim trailing whitespace.
vim.keymap.set("n", "<leader><space>", [[mz:%s/\s\+$//<cr>:let @/=''<cr>`z]])

-- My garbage brain can't ever remember digraph codes.
vim.keymap.set("i", "<c-k><c-k>", [[<esc>:help digraph-table<cr>]])

-- Only show cursorline in the current window and in normal mode.
local cline_group = vim.api.nvim_create_augroup("cline", { clear = true })
vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
  group = cline_group,
  callback = function()
    vim.o.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = cline_group,
  callback = function()
    vim.o.cursorline = true
  end,
})

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Quick editing some common dotfiles.
-- vim.keymap.set("n", "<leader>ef", ":vsplit ~/.config/fish/config.fish<cr>")
-- vim.keymap.set("n", "<leader>eg", ":vsplit ~/.gitconfig<cr>")
-- vim.keymap.set("n", "<leader>em", ":vsplit ~/.muttrc<cr>")
-- vim.keymap.set("n", "<leader>et", ":vsplit ~/.tmux.conf<cr>")
-- vim.keymap.set("n", "<leader>ev", ":vsplit ~/.config/nvim/init.lua<cr>")

-- 18 reading and writing files ----------------------------------- {{{1

vim.opt_global.backup = false
vim.opt_global.writebackup = false
vim.opt_global.autowrite = true
vim.opt_global.backupdir = vim.fn.expand("~/.config/nvim/tmp/backup//")
vim.opt_global.fixendofline = true

-- Make the backup directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.backupdir) == 0 then
  vim.fn.mkdir(vim.o.backupdir, "p")
end

-- 19 the swap file ----------------------------------------------- {{{1

vim.opt_global.directory = vim.fn.expand("~/.config/nvim/tmp/swap//")
vim.o.swapfile = false

-- Make the swap directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.directory) == 0 then
  vim.fn.mkdir(vim.o.directory, "p")
end

-- 20 command line editing ---------------------------------------- {{{1

vim.opt_global.wildmode = "list:longest"

-- 21 executing external commands --------------------------------- {{{1

-- 22 running make and jumping to errors -------------------------- {{{1

-- 23 language specific ------------------------------------------- {{{1

-- 24 multi-byte characters --------------------------------------- {{{1

-- > When on all Unicode emoji characters are considered to be full
-- > width.
--
-- Emoji of different byte lengths render funky in Vim without this
-- turned off.
vim.opt_global.emo = false

-- 25 various ----------------------------------------------------- {{{1

vim.cmd.colorscheme("catppuccin")

vim.opt_global.gdefault = true

-- The following settings aren't under `:options` at all, so it made the
-- most sense to throw them in the `25 various` junk-drawer.
vim.opt_global.ttyfast = true
vim.opt_global.startofline = false

-- Make sure Vim returns to the same line when you reopen a file.
local line_return_group = vim.api.nvim_create_augroup("line_return", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = line_return_group,
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]],
})

-- Always show the sign column so errors or other LSP features that use
-- the gutter don't continually pop in and out pushing everything over
-- by one column.
vim.opt.signcolumn = "yes"

-- Enable folding in Markdown.
vim.g.markdown_folding = 1

-- I don't care about Perl.
vim.g.loaded_perl_provider = 0

-- Default in vim for K is to open the man/help of what your cursor is
-- on.  This keeps that muscle memory alive but instead leans on the LSP
-- to provide the info.
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- Remap keys for gotos
-- Note: Intentionally not mapping `vim.lsp.buf.document_symbol` to
-- anything because I use the Vista plugin which is a nicer way to view
-- the document tree.
vim.keymap.set("n", "gd",  vim.lsp.buf.definition, { nowait = true })
vim.keymap.set("n", "gy",  vim.lsp.buf.type_definition, { nowait = true })
vim.keymap.set("n", "gi",  vim.lsp.buf.implementation)
vim.keymap.set("n", "gr",  vim.lsp.buf.references)
vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)

-- Remap for do codeAction of current line.
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Remap for auto-formatting code.
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting)

-- Use `[g` and `]g` for navigate diagnostics.
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- Remap for rename current word
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- Show only buffer diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)
-- Show only that line"s diagnostics.
vim.keymap.set("n", "<leader>ln", vim.diagnostic.get)
-- Trigger code lens.
-- See: https://github.com/scalameta/nvim-metals/discussions/160
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)

-- Need for symbol highlights to work correctly
vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
vim.cmd([[hi! link LspCodeLens CursorColumn]])

-- vim: set foldmethod=marker foldlevel=0 textwidth=72:
