-- 0  preamble ---------------------------------------------------- {{{1

-- This file groups the options into the same sections given by the
-- `:options` command and in the same order for reference.

vim.opt_global.shell = "fish"

-- All plugin settings are lower in this file under section 99.

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

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "github/copilot.vim", lazy = false },
  { "junegunn/vim-easy-align" },
  { "liuchengxu/vista.vim" },
  { "mbbill/undotree" },
  { "mfussenegger/nvim-dap" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" }
  },
  { "scalameta/nvim-metals", ft = { "sbt", "scala" } },
  { "tpope/vim-abolish" },
  { "tpope/vim-commentary" },
  { "tpope/vim-dadbod", lazy = true, ft = { "sql", "psql" } },
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
  },
  { "tpope/vim-eunuch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-jdaddy", lazy = true, ft = { "json" } },
  { "tpope/vim-projectionist" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-scriptease", lazy = true, ft = { "vim" } },
  { "tpope/vim-sensible" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-speeddating" },
  { "tpope/vim-surround" },
  { "tpope/vim-tbone" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-vinegar" },
})

-- 1  important --------------------------------------------------- {{{1

-- A |sentence| has to be followed by two spaces after the '.', '!' or '?'.
-- See: https://stevelosh.com/blog/2012/10/why-i-two-space/#s6-power
vim.o.cpo = vim.o.cpo .. "J"

-- 2  moving around, searching and patterns ----------------------- {{{1

vim.opt_global.ignorecase = true -- Ignore the case, unless...
vim.opt_global.smartcase = true  -- ...there's caps in it.

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
  vim.fn.expand "~/.vim/custom-dictionary.utf-8.add",
  vim.fn.expand "~/.vim-local-dictionary.utf-8.add",
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
if vim.fn.isdirectory(vim.o.undodir) == 0 then vim.fn.mkdir(vim.o.undodir, "p") end

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

vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"

-- 16 diff mode --------------------------------------------------- {{{1

-- 17 mapping ----------------------------------------------------- {{{1



-- This section contains the few options that are under `17 mapping` in
-- `:options` as well as all of my custom remappings that don't
-- sensibily fit in another section.  For example, the folding
-- remappings I have live  under `15 folding` but my `S` mapping for
-- splitting lines lives here.

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
local cline_group = vim.api.nvim_create_augroup("cline", { clear = true })
vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
  group = cline_group,
  callback = function()
    vim.o.cursorline = false
  end
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = cline_group,
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

-- 18 reading and writing files ----------------------------------- {{{1

vim.opt_global.backup = false
vim.opt_global.writebackup = false
vim.opt_global.autowrite = true
vim.opt_global.backupdir = vim.fn.expand("~/.config/nvim/tmp/backup//")
vim.opt_global.fixendofline = true

-- Make the backup directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.backupdir) == 0
then
  vim.fn.mkdir(vim.o.backupdir, "p")
end

-- 19 the swap file ----------------------------------------------- {{{1

vim.opt_global.directory = vim.fn.expand("~/.config/nvim/tmp/swap//")
vim.o.swapfile = false

-- Make the swap directory automatically if it doesn't already exist.
if vim.fn.isdirectory(vim.o.directory) == 0
then
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

vim.opt_global.gdefault = true

-- The following settings aren't under `:options` at all, so it made the
-- most sense to throw them in the `25 various` junk-drawer.
vim.opt_global.ttyfast = true
vim.opt_global.startofline = false

-- Make sure Vim returns to the same line when you reopen a file.
local line_return_group = vim.api.nvim_create_augroup("line_return", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = line_return_group,
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]]
})

-- Always show the sign column so errors or other LSP features that use
-- the gutter don't continually pop in and out pushing everything over
-- by one column.
vim.opt.signcolumn = "yes"

-- Enable folding in Markdown.
vim.g.markdown_folding = 1

-- I don't care about Perl.
vim.g.loaded_perl_provider = 0

-- 99 plugin configurations --------------------------------------- {{{1

-- Catppuccin {{{2

local catppuccin = require("catppuccin")

catppuccin.setup({
  flavour = "frappe",
  transparent_background = true,
  term_colors = true,
})

vim.cmd.colorscheme "catppuccin"


-- DAP (Debug Adapter Protocol) {{{2

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

-- Dispatch {{{2

vim.keymap.set("n", "<F9>", ":Dispatch<CR>")

-- EasyAlign {{{2

-- Start interactive EasyAlign in visual mode (e.g. vipga).
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[xmap ga <Plug>(EasyAlign)]])

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- Intentionally not using `nnoremap`.
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[nmap ga <Plug>(EasyAlign)]])

-- LSP Zero {{{2

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

lsp.configure('metals', { force_setup = true })

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }
})

-- Lualine {{{2

local lualine = require("lualine")

lualine.setup({
  options = {
    theme = "catppuccin"
  },
  sections = {
    lualine_x = {'g:metals_status', 'encoding', 'fileformat', 'filetype'},
  }
})

-- Metals {{{2

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
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  showImplicitArguments = true,
  showInferredType = true,
  superMethodLensesEnabled = true,
  useGlobalExecutable = true, -- So we can use LSP Zero.  This means we have to keep Metals up-to-date ourselves.
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

-- Projectionist {{{2

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

-- Rhubarb {{{2

vim.g["github_enterprise_urls"] = { "https://code.corp.creditkarma.com" }

-- Telescope {{{2

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leader>gf", builtin.git_files)
vim.keymap.set("n", "<leader>fm", require("telescope").extensions.metals.commands)

-- Treesitter {{{2

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

-- UndoTree {{{2

vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")

-- Vista {{{2

vim.g["vista_icon_indent"] = { "╰─▸ ", "├─▸ " }
vim.g["vista_default_executive"] = "nvim_lsp"
vim.g["vista#renderer#enable_icon"] = 1

vim.keymap.set("n", "<leader>t", ":<C-u>Vista!!<CR>")

-- vim: set foldmethod=marker foldlevel=0 textwidth=72:
