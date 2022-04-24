-- 0  preamble ----------------------------------------------------- {{{

-- Jesse Atkinson | jesse@jsatk.us | @jsatk | https://jsatk.us

-- This file groups the options into the same sections given by the
-- `:options` command and in the same order for reference.

-- Setup {{{

vim.opt_global.shell = "fish"

-- }}}
-- Plugins {{{

-- All plugin settings are lower in this file under section 99.

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
vim.opt.list = true

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
vim.opt_global.spellfile = {
  vim.fn.expand "~/.vim/custom-dictionary.utf-8.add",
  vim.fn.expand "~/.vim-local-dictionary.utf-8.add",
}
vim.keymap.set("n", "zG", "2zg")

vim.cmd([[hi! Comment gui=italic]]) -- No lua equivelent yet.

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

vim.o.showcmd = true
vim.o.showmode = true

-- Avoid showing message extra message when using completion
-- Ensure autocmd works for Filetype
vim.opt.shortmess:remove("F")
vim.opt.shortmess:append("c")

-- }}}
-- 12 selecting text ----------------------------------------------- {{{

-- }}}
-- 13 editing text ------------------------------------------------- {{{

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

vim.o.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"

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

vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- Do not show stupid q: window
vim.keymap.set("", "q:", ":q")
-- I don't know how to use ex mode and it scares me.
vim.keymap.set("", "Q", "<Nop>")
-- Split line (sister to [J]oin lines)
vim.keymap.set("n", "S", "i<cr><esc><right>")
-- switch to last file
vim.keymap.set("n", "<leader><leader>", "<c-^>")
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
local cline = vim.api.nvim_create_augroup("cline", { clear = true })
vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
  group = cline,
  callback = function()
    vim.o.cursorline = false
  end
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = cline,
  callback = function()
    vim.o.cursorline = true
  end
})

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Quick editing some common dotfiles.
vim.keymap.set("n", "<leader>ef", ":vsplit ~/.config/fish/config.fish<cr>")
vim.keymap.set("n", "<leader>eg", ":vsplit ~/.gitconfig<cr>")
vim.keymap.set("n", "<leader>em", ":vsplit ~/.muttrc<cr>")
vim.keymap.set("n", "<leader>et", ":vsplit ~/.tmux.conf<cr>")
vim.keymap.set("n", "<leader>ev", ":vsplit ~/.config/nvim/init.lua<cr>")

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
vim.o.swapfile = false

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
local line_return = vim.api.nvim_create_augroup("line_return", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = line_return,
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]]
})

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
local types = require("cmp.types")

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
  mapping = {
    ['<Down>'] = cmp.config.mapping({
      i = cmp.config.mapping.select_next_item({
        behavior = types.cmp.SelectBehavior.Select
      }),
      c = function(fallback)
        cmp.close()
        vim.schedule(cmp.suspend())
        fallback()
      end,
    }),
    ['<Up>'] = cmp.config.mapping({
      i = cmp.config.mapping.select_prev_item({
        behavior = types.cmp.SelectBehavior.Select
      }),
      c = function(fallback)
        cmp.close()
        vim.schedule(cmp.suspend())
        fallback()
      end,
    }),
    ['<C-d>'] = cmp.config.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.config.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.config.mapping.complete(),
    ['<CR>'] = cmp.config.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-n>'] = cmp.config.mapping(
      cmp.config.mapping.select_next_item({
        behavior = types.cmp.SelectBehavior.Insert
      }),
      { 'i', 'c' }
    ),
    ['<C-p>'] = cmp.config.mapping(
      cmp.config.mapping.select_prev_item({
        behavior = types.cmp.SelectBehavior.Insert
      }),
      { 'i', 'c' }
    ),
    ['<C-y>'] = cmp.config.mapping.confirm({ select = false }),
    ['<C-e>'] = cmp.config.mapping.abort(),
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
    native_menu = false,
    ghost_text = true,
  },
})

-- }}}
-- DAP (Debug Adapter Protocol) {{{

local dap = require("dap")

-- Mnemonic to remember these:
-- <leader>d - "d" for DAP
-- "c" for "continue".
vim.keymap.set("n", "<leader>dc", dap.continue)
-- "r" for "REPL".
vim.keymap.set("n", "<leader>dr", dap.repl.open)
-- "tb" for "toggle breakpoint".
vim.keymap.set("n", "<leader>dtb", dap.toggle_breakpoint)
-- "so" for "step over".
vim.keymap.set("n", "<leader>dso", dap.step_over)
-- "si" for "step into".
vim.keymap.set("n", "<leader>dsi", dap.step_into)

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

vim.keymap.set("n", "<F9>", ":Dispatch<CR>")

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

vim.keymap.set("n", "<F5>", ":GundoToggle<CR>")

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
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- Remap keys for gotos
vim.keymap.set("n", "gd",  vim.lsp.buf.definition, { nowait = true })
vim.keymap.set("n", "gy",  vim.lsp.buf.type_definition, { nowait = true })
vim.keymap.set("n", "gi",  vim.lsp.buf.implementation)
vim.keymap.set("n", "gr",  vim.lsp.buf.references)
vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)

-- Remap for do codeAction of current line.
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Remap for auto-formatting code.
vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting)

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
vim.keymap.set("n", "<leader>ws", require("metals").hover_worksheet)

-- Show all diagnostics
-- Note: You can limit the diagnostics you see by passing in `severity`
-- of `"E"` or `"W"`.
--
-- Example:
-- ```lua
-- vim.diagnostic.setqflist({severity = "E"}) // all errors
-- vim.diagnostic.setqflist({severity = "W"}) // all warnings
-- ```
vim.keymap.set("n", "<leader>a", vim.diagnostic.setqflist)

local metals_config = require("metals").bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  superMethodLensesEnabled = true
}

metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { prefix = "" }
  }
)

-- Exhaustive match support, etc.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

metals_config.capabilities = capabilities

metals_config.init_options.statusBarProvider = "on"

-- For DAP.
metals_config.on_attach = function(_, _)
  require("metals").setup_dap()
end

local lsp = vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  group = lsp,
  pattern = "*.scala",
  callback = function()
    vim.o.cursorline = false
  end
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = cline,
  callback = function()
    vim.o.cursorline = true
  end
})

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Make the CodeLens color not the same color as the regular code.
vim.api.nvim_create_autocmd("ColorScheme", {
  command = "hi! link LspCodeLens CursorLine",
})

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
      console = "bloop-jvm console",
      make = "bloop-jvm compile",
      start = "bloop-jvm run"
    },
    ["src/main/scala/*.scala"] = {
      alternate = "src/test/scala/{}Test.scala",
      type = "src"
    },
    ["src/test/scala/*Test.scala"] = {
      alternate = "src/main/scala/{}.scala",
      type = "test",
      dispatch = "bloop-jvm test --no-color -o {dot}Test"
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

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches)
vim.keymap.set("n", "<leader>fm", require("telescope").extensions.metals.commands)

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

vim.keymap.set("n", "<leader>t", ":<C-u>Vista!!<CR>")

-- }}}

-- }}}

-- vim: set foldmethod=marker foldlevel=0 textwidth=72 colorcolumn=80:
