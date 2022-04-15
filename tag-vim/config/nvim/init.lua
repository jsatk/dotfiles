-- 0  preamble ----------------------------------------------------- {{{

-- Jesse Atkinson | jesse@jsatk.us | @jsatk | https://jsatk.us

-- This file groups the options into the same sections given by the
-- `:options` command and in the same order for reference.

-- Setup {{{

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt_global.shell = "fish"

-- }}}
-- Plugins {{{

-- All plugins are in ~/.config/nvim/lua/plugins.lua.
-- All individual plugin settings are in
-- ~/.config/nvim/lua/settings/$PLUGIN_NAME.

-- Only required if you have packer in your `opt` pack.
vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
  -- Packer can manage itself as an optional plugin.
  use({ "wbthomason/packer.nvim", opt = true})

  -- The plugins, sorted alphabetically.
  use({ "AndrewRadev/splitjoin.vim" })
  use({ "ap/vim-css-color", opt = true, ft = { "css", "scss", "sass", "less" }})
  use({ "dag/vim-fish", opt = true, ft = "fish" })
  use({ "github/copilot.vim" })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "onsails/lspkind-nvim" },
    }
  })
  use({ "navarasu/onedark.nvim" })
  use({ "junegunn/goyo.vim", opt = true, ft = { "markdown", "tex", "mail" }})
  use({ "junegunn/gv.vim" })
  use({ "junegunn/vim-easy-align" })
  use({ "junegunn/vim-peekaboo" })
  use({ "liuchengxu/vista.vim" })
  use({ "mfussenegger/nvim-dap" })
  use({ "neovim/nvim-lspconfig", requires = { "nvim-lua/lsp_extensions.nvim" }})
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    }
  })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "scalameta/nvim-metals" })
  use({ "sheerun/vim-polyglot" })
  use({ "sjl/gundo.vim" })
  use({ "tpope/vim-abolish" })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-dadbod", opt = true, ft = { "sql", "psql" }})
  use({
    "tpope/vim-dispatch",
    opt = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" }
  })
  use({ "tpope/vim-eunuch" })
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-jdaddy", opt = true, ft = { "json" }})
  use({ "tpope/vim-projectionist" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-rhubarb" })
  use({ "tpope/vim-scriptease", opt = true, ft = "vim" })
  use({ "tpope/vim-sensible" })
  use({ "tpope/vim-sleuth" })
  use({ "tpope/vim-speeddating" })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-tbone" })
  use({ "tpope/vim-unimpaired" })
  use({ "tpope/vim-vinegar" })
end)

-- }}}

-- }}}
-- 1  important ---------------------------------------------------- {{{

-- A |sentence| has to be followed by two spaces after the '.', '!' or '?'.
-- See: https://stevelosh.com/blog/2012/10/why-i-two-space/#s6-power
vim.o.cpo = vim.o.cpo .. "J"

-- }}}
-- 2  moving around, searching and patterns ------------------------ {{{

vim.opt_global.ignorecase = true -- Ignore the case, unless...
vim.opt_global.smartcase = true  -- ...there's caps in it.

-- }}}
-- 3  tags --------------------------------------------------------- {{{

-- }}}
-- 4  displaying text ---------------------------------------------- {{{

vim.opt_global.scrolloff = 3
vim.opt_global.linebreak = true
vim.opt_global.breakindent = true
vim.opt_global.showbreak = "↪"
vim.opt_global.lazyredraw = true
vim.opt_global.list = true

-- }}}
-- 5  syntax, highlighting and spelling ---------------------------- {{{

-- NOTE: My colorscheme OneDark's settings is defined in the plugins
-- section.

vim.opt_global.background = "dark"
vim.opt_global.termguicolors = true

vim.g["onedark_terminal_italics"] = 1

vim.opt_global.synmaxcol = 800
vim.opt_global.hlsearch = true
vim.opt_global.cursorline = true
vim.opt_global.guifont = "OperatorMonoForPowerline-Book:h18"

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
vim.cmd("set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add")
map("n", "zG", "2zg")

vim.cmd([[hi! Comment gui=italic]])

-- Highlight VCS conflict markers
vim.fn.matchadd("ErrorMsg", "^\\(<\\|=\\|>\\)\\{7\\}\\([^=].\\+\\)\\?$")

-- }}}
-- 6  multiple windows --------------------------------------------- {{{

vim.opt_global.hidden = true
vim.opt_global.splitbelow = true
vim.opt_global.splitright = true

-- }}}
-- 7  multiple tab pages ------------------------------------------- {{{

-- }}}
-- 8  terminal ----------------------------------------------------- {{{

vim.opt_global.title = true

-- }}}
-- 9  using the mouse ---------------------------------------------- {{{

if vim.fn.has("mouse") == 1 then
  vim.opt_global.mouse = "a"
end

-- }}}
-- 10 printing ----------------------------------------------------- {{{

-- }}}
-- 11 messages and info -------------------------------------------- {{{

vim.opt_global.showcmd = true
vim.opt_global.showmode = true

-- Avoid showing message extra message when using completion
-- Ensure autocmd works for Filetype
vim.o.shortmess = string.gsub(vim.o.shortmess, "F", "") .. "c"

-- }}}
-- 12 selecting text ----------------------------------------------- {{{

-- }}}
-- 13 editing text ------------------------------------------------- {{{

vim.opt_global.textwidth = 0
vim.opt_global.wrapmargin = 0
vim.opt_global.dictionary = "/usr/share/dict/words"
vim.opt_global.showmatch = true
vim.opt_global.nrformats = "octal,hex,alpha" -- Increment alpha strings with Vim.

-- As of this writing (2021-02-13) for reasons unknown vim.o.undofile
-- isn't a thing so we can't set it
vim.cmd("set undofile")
-- The extra slash on the end saves files under the name of their full path
-- with the / character replaced with a %.
vim.opt_global.undodir = vim.fn.expand("~/.config/nvim/tmp/undo//")
-- Make the undo directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.undodir) == 0 then vim.fn.mkdir(vim.o.undodir, "p") end

-- Set completeopt to have a better completion experience
vim.opt_global.completeopt = "menuone,noinsert,noselect"

-- }}}
-- 14 tabs and indenting ------------------------------------------- {{{

vim.opt_global.shiftwidth = 2
vim.opt_global.softtabstop = 2
vim.opt_global.shiftround = true
vim.opt_global.expandtab = true

-- }}}
-- 15 folding ------------------------------------------------------ {{{

vim.opt_global.foldenable = true
vim.opt_global.foldlevelstart = 0

map("n", "<Space>", "za")
map("v", "<Space>", "za")
map("n", "z0", "zcz0")

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

-- TODO: Convert to lua when we can.
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")

-- }}}
-- 16 diff mode ---------------------------------------------------- {{{

-- }}}
-- 17 mapping ------------------------------------------------------ {{{

-- This section contains the few options that are under `17 mapping` in
-- `:options` as well as all of my custom remappings that don't sensibily
-- fit in another section.  For example, the folding remappings I have
-- live  under `15 folding` but my `S` mapping for splitting lines lives
-- here.

vim.opt_global.timeoutlen = 500

vim.g["mapleader"] = ","
vim.g["maplocalleader"] = ","
-- Do not show stupid q: window
map("", "q:", ":q")
-- I don't know how to use ex mode and it scares me.
map("", "Q", "<Nop>")
-- Split line (sister to [J]oin lines)
map("n", "S", "i<cr><esc><right>")
-- switch to last file
map("n", "<leader><leader>", "<c-^>")
-- redraw the buffer
map("n", "<leader>r", ":syntax sync fromstart<cr>:redraw!<cr>")

-- Keep search matches in the middle of the window.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Trim trailing whitespace.
map("n", "<leader><space>", [[mz:%s/\s\+$//<cr>:let @/=''<cr>`z]])

-- Only show when not in insert mode.
vim.cmd([[augroup trailing]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd InsertEnter * :set listchars-=trail:⌴]])
vim.cmd([[autocmd InsertLeave * :set listchars+=trail:⌴]])
vim.cmd([[augroup END]])

-- My garbage brain can't ever remember digraph codes.
map("i", "<c-k><c-k>", [[<esc>:help digraph-table<cr>]])

-- Only show cursorline in the current window and in normal mode.
vim.cmd([[augroup cline]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd WinLeave,InsertEnter * set nocursorline]])
vim.cmd([[autocmd WinEnter,InsertLeave * set cursorline]])
vim.cmd([[augroup END]])

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

-- TODO: Toggle quickfix
-- function! QuickFixIsOpen()
--   let l:result = filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
--   return !empty(l:result)
-- endfunction
-- nnoremap yoq :<C-R>=QuickFixIsOpen() ? "cclose" : "copen"<CR><CR>

-- Quick editing some common dotfiles.
map("n", "<leader>ed", ":vsplit ~/.vim/custom-dictionary.utf-8.add<cr>")
map("n", "<leader>ef", ":vsplit ~/.config/fish/config.fish<cr>")
map("n", "<leader>eg", ":vsplit ~/.gitconfig<cr>")
map("n", "<leader>em", ":vsplit ~/.muttrc<cr>")
map("n", "<leader>ep", ":vsplit ~/Developer/jsatk.us/content/dotplan.md<cr>")
map("n", "<leader>et", ":vsplit ~/.tmux.conf<cr>")
map("n", "<leader>ev", ":vsplit ~/.config/nvim/init.lua<cr>")

-- }}}
-- 18 reading and writing files ------------------------------------ {{{

vim.opt_global.backup = false
vim.opt_global.writebackup = false
vim.opt_global.autowrite = true
vim.opt_global.backupdir = vim.fn.expand("~/.config/nvim/tmp/backup//")
vim.opt_global.fixendofline = true

-- Make the backup directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.backupdir) == 0 then vim.fn.mkdir(vim.o.backupdir, "p") end

-- }}}
-- 19 the swap file ------------------------------------------------ {{{

vim.opt_global.directory = vim.fn.expand("~/.config/nvim/tmp/swap//")
-- As of this writing (2021-02-13) for reasons unknown vim.o.noswapfile
-- isn't a thing in Lua + Neovim so we can't set it.
vim.cmd("set noswapfile")

-- Make the swap directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.directory) == 0 then vim.fn.mkdir(vim.o.directory, "p") end

-- }}}
-- 20 command line editing ----------------------------------------- {{{

vim.opt_global.wildmode = "list:longest"

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
vim.opt_global.emo = false

-- }}}
-- 25 various ------------------------------------------------------ {{{

vim.opt_global.gdefault = true

-- The following settings aren't under `:options` at all, so it made the
-- most sense to throw them in the `25 various` junk-drawer.
vim.opt_global.ttyfast = true
vim.opt_global.startofline = false

-- Make sure Vim returns to the same line when you reopen a file.
vim.cmd([[augroup line_return]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]])
vim.cmd([[augroup END]])

-- Always show the sign column so errors or other LSP features that use
-- the gutter don't continually pop in and out pushing everything over
-- by one column.
vim.opt.signcolumn = "yes"

-- }}}
-- 99 plugin configurations ---------------------------------------- {{{

-- Cmp {{{

local lspkind = require("lspkind")
lspkind.init()
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- There are several default mappints defined in default.lua by the
  -- plugin's author.
  -- See: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L83
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        vsnip = "[vsnip]",
      },
    },
  },
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,
    -- Let's play with this for a day or two
    ghost_text = true,
  },
})

-- }}}
-- DAP (Debug Adapter Protocol) {{{

-- Mnemonic to remember these:
-- <leader>d - "d" for DAP
-- "c" for "continue".
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
-- "r" for "REPL".
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
-- "tb" for "toggle breakpoint".
map("n", "<leader>dtb", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
-- "so" for "step over".
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
-- "si" for "step into".
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
-- "s" for "scopes".  I realize this can be confused with `so` and `si`
-- but there's little to no harm in acidentally triggering `.scopes()`
-- so at worst if I don't press the `so` or `si` fast enough I'll just
-- see the scopes. ¯\_(ツ)_/¯
map("n", "<leader>ds", [[<cmd>lua require"dap.ui.variables".scopes()<CR>]])

local dap = require("dap")

vim.fn.sign_define('DapBreakpoint', { text="🛑", texthl="", linehl="", numhl="" })
vim.fn.sign_define('DapStopped', { text="✋", texthl="", linehl="", numhl="" })
vim.fn.sign_define('DapLogPoint', { text="📝", texthl="", linehl="", numhl="" })

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run",
    metals = {
      runType = "run"
    }
  },
  {
    type = "scala",
    request = "launch",
    name = "Test File",
    metals = {
      runType = "testFile"
    }
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget"
    }
  },
}

-- }}}
-- Dispatch {{{

-- Why am I doing this?  See link below.
-- See: https://github.com/tpope/vim-dispatch/issues/222#issuecomment-493273080
vim.opt_global.shellpipe = "2>&1|tee"

map("n", "<F9>", ":Dispatch<CR>")

-- }}}
-- EasyAlign {{{

-- Start interactive EasyAlign in visual mode (e.g. vipga).
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[xmap ga <Plug>(EasyAlign)]])

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- Intentionally not using `nnoremap`.
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[nmap ga <Plug>(EasyAlign)]])

-- }}}
-- Gundo {{{

map("n", "<F5>", ":GundoToggle<CR>")

-- }}}
-- Lualine {{{

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#282c34',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return ''
  end,
  color = 'LualineMode',
  padding = { right = 1 },
})

ins_left({
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
})

ins_left({
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
})

ins_left({ 'location' })

ins_left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

ins_left({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

ins_left({ 'g:metals_status' })

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return '%='
  end,
})

ins_left({
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
})

-- Add components to right sections
ins_right({
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
})

ins_right({
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
})

ins_right({
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
})

ins_right({
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)

-- }}}
-- Lsp + Lspconfig {{{

-- This section contains Neovim LSP settings as well as settings for the
-- Lspconfig plugin.  I know it's not "pure" in an organizational sense,
-- but this felt correct and logical; especially since Neovim's LSP is
-- not listed in :options and – as stated in my giant preamble – I've
-- chosen to organize the settings in this file to mirror the order they
-- are in in :options.  So yeah, both are mixed in here. ¯\_(ツ)_/¯

-- Default in vim for K is to open the man/help of what your cursor is
-- on.  This keeps that muscle memory alive but instead leans on the LSP
-- to provide the info.
-- TODO: Rewrite this so if LSP is active it uses hover otherwise does
--       the default action.
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])

-- Remap keys for gotos
map("n", "gd",  [[<cmd>lua vim.lsp.buf.definition()<CR>]], { nowait = true })
map("n", "gy",  [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], { nowait = true })
map("n", "gi",  [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "gr",  [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "gds", [[<cmd>lua vim.lsp.buf.document_symbol()<CR>]])
map("n", "gws", [[<cmd>lua vim.lsp.buf.workspace_symbol()<CR>]])

-- Remap for do codeAction of current line.
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])

-- Remap for auto-formatting code.
map("n", "<leader>f", [[<cmd>lua vim.lsp.buf.formatting()<CR>]])

-- Use `[g` and `]g` for navigate diagnostics.
map("n", "]g", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
map("n", "[g", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])

-- Remap for rename current word
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])

-- Show only buffer diagnostics
map("n", "<leader>d", [[<cmd>lua vim.diagnostic.setloclist()<CR>]])
-- Show only that line"s diagnostics.
map("n", "<leader>ln", [[<cmd>lua vim.diagnostic.get()<CR>]])
-- Trigger code lens.
-- See: https://github.com/scalameta/nvim-metals/discussions/160
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])

-- Need for symbol highlights to work correctly
vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
vim.cmd([[hi! link LspCodeLens CursorColumn]])

-- List of LSPs to enable via nvim-lspconfig.
-- To see full list of available lsps please see the list here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#gopls
-- Also note that Scala/Metals is *not* configured via lspconfig but
-- rather though ckipp's nvim-metals plugin.  See that plugin's README
-- for more details on that.

require("lspconfig").bashls.setup {}
require("lspconfig").dockerls.setup {}
require("lspconfig").gopls.setup {}
require("lspconfig").graphql.setup {}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
require("lspconfig").terraformls.setup {}
require("lspconfig").tsserver.setup {}
require("lspconfig").vimls.setup {}

-- }}}
-- Metals {{{

-- Mostly stolen from Chris Kipp.
-- See: https://github.com/scalameta/nvim-metals/discussions/39#discussion-82302

-- Used to expand decorations in worksheets
map("n", "<leader>ws", [[<cmd>lua require'metals'.worksheet_hover()<CR>]])

-- Show all diagnostics
-- Note: You can limit the diagnostics you see by passing in `severity`
-- of `"E"` or `"W"`.
--
-- Example:
-- ```lua
-- vim.diagnostic.setqflist({severity = "E"}) // all errors
-- vim.diagnostic.setqflist({severity = "W"}) // all warnings
-- ```
map("n", "<leader>a", [[<cmd>lua vim.diagnostic.setqflist()<CR>]])

Metals_config = require("metals").bare_config()

-- Example of settings
Metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  superMethodLensesEnabled = true
}

-- Example of how to ovewrite a handler
Metals_config.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = { prefix = "" }})

-- Exhaustive match support, etc.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

Metals_config.capabilities = capabilities

Metals_config.init_options.statusBarProvider = "on"

-- For DAP.
Metals_config.on_attach = function(_, _)
  require("metals").setup_dap()
end

vim.cmd([[augroup lsp]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])
vim.cmd([[augroup END]])

-- Make the CodeLens color not the same color as the regular code.
vim.cmd([[autocmd ColorScheme * highlight link LspCodeLens Conceal]])

-- }}}
-- OneDark {{{

require("onedark").setup { style = "cool" }
require("onedark").load()

-- }}}
-- Projectionist {{{

vim.g.projectionist_heuristics = {
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

vim.g["github_enterprise_urls"] = { "https://code.corp.creditkarma.com" }

-- }}}
-- Telescope {{{

map("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
map("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
map("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
map("n", "<leader>gb", [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])
map("n", "<leader>fm", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])

-- }}}
-- Treesitter {{{

require("nvim-treesitter.configs").setup {
  -- Needed for Treesitter playground
  playground = { enabled = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" }
  },
  ensure_installed = {
    "bash",
    "commonlisp",
    "css",
    "dockerfile",
    "fish",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "php",
    "rust",
    "scala",
    "scss",
    "toml",
    "typescript",
    "vim",
    "yaml"
  },
  highlight = { enable = true }
}

-- }}}
-- Vista {{{

vim.g["vista_icon_indent"] = { "╰─▸ ", "├─▸ " }
vim.g["vista_default_executive"] = "nvim_lsp"
vim.g["vista#renderer#enable_icon"] = 1

map("n", "<leader>t", ":<C-u>Vista!!<CR>")

-- }}}

-- }}}

-- vim: set foldmethod=marker foldlevel=0 textwidth=72 colorcolumn=80:
