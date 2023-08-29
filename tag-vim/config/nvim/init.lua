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
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = true,
      term_colors = true,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        -- neotest = true,
        -- noice = true,
        -- notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
  },

  { "junegunn/vim-easy-align" },

  {
    "L3MON4D3/LuaSnip",
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  { "liuchengxu/vista.vim" },

  { "mbbill/undotree" },

  {
    "mfussenegger/nvim-dap",
    keys = {
      -- Mnemonic to remember these:
      -- <leader>d - "d" for DAP
      -- "c" for "continue".
      { "<leader>dc", function() require("dap").continue() end },
      -- "r" for "REPL".
      { "<leader>dr", function() require("dap").repl.open() end },
      -- "tb" for "toggle breakpoint".
      { "<leader>dtb", function() require("dap").toggle_breakpoint() end },
      -- "so" for "step over".
      {"<leader>dso", function() require("dap").step_over() end },
      -- "si" for "step into".
      { "<leader>dsi", function() require("dap").step_into() end },
    },
    config = function()
      local dap = require("dap")

      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run",
          metals = {
            runType = "run",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test File",
          metals = {
            runType = "testFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvim-lua/lsp_extensions.nvim",
    },
    ---@class PluginLspOpts
    -- opts = {
    --   -- options for vim.diagnostic.config()
    --   diagnostics = {
    --     underline = true,
    --     update_in_insert = false,
    --     virtual_text = {
    --       spacing = 4,
    --       source = "if_many",
    --       prefix = "●",
    --       -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --       -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --       -- prefix = "icons",
    --     },
    --     severity_sort = true,
    --   },
    --   -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    --   -- Be aware that you also will need to properly configure your LSP server to
    --   -- provide the inlay hints.
    --   inlay_hints = {
    --     enabled = false,
    --   },
    --   -- add any global capabilities here
    --   capabilities = {},
    --   -- Automatically format on save
    --   autoformat = true,
    --   -- Enable this to show formatters used in a notification
    --   -- Useful for debugging formatter issues
    --   format_notify = false,
    --   -- options for vim.lsp.buf.format
    --   -- `bufnr` and `filter` is handled by the LazyVim formatter,
    --   -- but can be also overridden when specified
    --   format = {
    --     formatting_options = nil,
    --     timeout_ms = nil,
    --   },
    --   -- LSP Server Settings
    --   ---@type lspconfig.options
    --   servers = {
    --     jsonls = {},
    --     lua_ls = {
    --       -- mason = false, -- set to false if you don't want this server to be installed with mason
    --       -- Use this to add any additional keymaps
    --       -- for specific lsp servers
    --       ---@type LazyKeys[]
    --       -- keys = {},
    --       settings = {
    --         Lua = {
    --           workspace = {
    --             checkThirdParty = false,
    --           },
    --           completion = {
    --             callSnippet = "Replace",
    --           },
    --         },
    --       },
    --     },
    --   },
    --   -- you can do any additional lsp server setup here
    --   -- return true if you don't want this server to be setup with lspconfig
    --   ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    --   setup = {
    --     -- example to setup with typescript.nvim
    --     -- tsserver = function(_, opts)
    --     --   require("typescript").setup({ server = opts })
    --     --   return true
    --     -- end,
    --     -- Specify * to use this function as a fallback for any server
    --     -- ["*"] = function(server, opts) end,
    --   },
    -- },
    ---@param opts PluginLspOpts
    -- config = function(_, opts)
    --   local Util = require("lazyvim.util")

    --   if Util.has("neoconf.nvim") then
    --     local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
    --     require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
    --   end
    --   -- setup autoformat
    --   require("lazyvim.plugins.lsp.format").setup(opts)
    --   -- setup formatting and keymaps
    --   Util.on_attach(function(client, buffer)
    --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    --   end)

    --   local register_capability = vim.lsp.handlers["client/registerCapability"]

    --   vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    --     local ret = register_capability(err, res, ctx)
    --     local client_id = ctx.client_id
    --     ---@type lsp.Client
    --     local client = vim.lsp.get_client_by_id(client_id)
    --     local buffer = vim.api.nvim_get_current_buf()
    --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    --     return ret
    --   end

    --   -- diagnostics
    --   for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
    --     name = "DiagnosticSign" .. name
    --     vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    --   end

    --   local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    --   if opts.inlay_hints.enabled and inlay_hint then
    --     Util.on_attach(function(client, buffer)
    --       if client.supports_method('textDocument/inlayHint') then
    --         inlay_hint(buffer, true)
    --       end
    --     end)
    --   end

    --   if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    --     opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
    --       or function(diagnostic)
    --         local icons = require("lazyvim.config").icons.diagnostics
    --         for d, icon in pairs(icons) do
    --           if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
    --             return icon
    --           end
    --         end
    --       end
    --   end

    --   vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    --   local servers = opts.servers
    --   local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    --   local capabilities = vim.tbl_deep_extend(
    --     "force",
    --     {},
    --     vim.lsp.protocol.make_client_capabilities(),
    --     has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    --     opts.capabilities or {}
    --   )

    --   local function setup(server)
    --     local server_opts = vim.tbl_deep_extend("force", {
    --       capabilities = vim.deepcopy(capabilities),
    --     }, servers[server] or {})

    --     if opts.setup[server] then
    --       if opts.setup[server](server, server_opts) then
    --         return
    --       end
    --     elseif opts.setup["*"] then
    --       if opts.setup["*"](server, server_opts) then
    --         return
    --       end
    --     end
    --     require("lspconfig")[server].setup(server_opts)
    --   end

    --   -- get all the servers that are available thourgh mason-lspconfig
    --   local have_mason, mlsp = pcall(require, "mason-lspconfig")
    --   local all_mslp_servers = {}
    --   if have_mason then
    --     all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    --   end

    --   local ensure_installed = {} ---@type string[]
    --   for server, server_opts in pairs(servers) do
    --     if server_opts then
    --       server_opts = server_opts == true and {} or server_opts
    --       -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
    --       if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
    --         setup(server)
    --       else
    --         ensure_installed[#ensure_installed + 1] = server
    --       end
    --     end
    --   end

    --   if have_mason then
    --     mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    --   end

    --   if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
    --     local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
    --     Util.lsp_disable("tsserver", is_deno)
    --     Util.lsp_disable("denols", function(root_dir)
    --       return not is_deno(root_dir)
    --     end)
    --   end
    -- end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        -- formatting = {
        --   format = function(_, item)
        --     local icons = require("lazyvim.config").icons.kinds
        --     if icons[item.kind] then
        --       item.kind = icons[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      -- {
      --   "<leader>fe",
      --   function()
      --     require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
      --   end,
      --   desc = "Explorer NeoTree (root dir)",
      -- },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
     dependencies = {
       { "nvim-lua/popup.nvim" },
       { "nvim-lua/plenary.nvim" },
       { "nvim-tree/nvim-web-devicons" },
     },
    commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>ff", "<cmd>Telescope git_files" },
      { "<leader>/", function() require("telescope.builtin").live_grep() end },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end },
      { "<leader>,", function() require("telescope.builtin").buffers() end },
      { "<leader>fb", function() require("telescope.builtin").buffers() end },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end },
      { "<leader>gb", function() require("telescope.builtin").git_branches() end },
      { "<leader>fr", function() require("telescope.builtin").oldfiles() end },
      { "<leader>:", function() require("telescope.builtin").command_history() end },
      { "<leader>sr", function() require("telescope.builtin").registers() end },
      { "<leader>sh", function() require("telescope.builtin").help_tags() end },
      { "<leader>sk", function() require("telescope.builtin").keymaps() end },
      { "<leader>sm", function() require("telescope.builtin").man_pages() end },
      { "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end },
      { "<leader>sS", function() require("telescope.builtin").lsp_workspace_symbols() end },
      { "<leader>fm", function() require("telescope").extensions.metals.commands() end },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<a-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              require("telescope.builtin").find_files({ no_ignore = true, default_text = line })()
            end,
            ["<a-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              require("telescope.builtin").find_files({ hidden = true, default_text = line })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
  },
  {
    "scalameta/nvim-metals",
    ft = { "sbt", "scala" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      theme = "auto",
    },
    sections = {
      lualine_x = { 'g:metals_status', 'encoding', 'fileformat', 'filetype' },
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      -- require("lazyvim.util").on_attach(function(client, buffer)
      --   if client.server_capabilities.documentSymbolProvider then
      --     require("nvim-navic").attach(client, buffer)
      --   end
      -- end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        -- icons = require("lazyvim.config").icons.kinds,
      }
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  {
    "williamboman/mason.nvim",
  },

  { "tpope/vim-abolish" },
  { "tpope/vim-dadbod", lazy = true, ft = { "sql", "psql" } },
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
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

-- 99 plugin configurations --------------------------------------- {{{1

-- Catppuccin {{{2


-- DAP (Debug Adapter Protocol) {{{2


-- EasyAlign {{{2

-- Start interactive EasyAlign in visual mode (e.g. vipga).
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[xmap ga <Plug>(EasyAlign)]])

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- Intentionally not using `nnoremap`.
-- Note: Using |:*noremap| will not work with <Plug> mappings.
vim.cmd([[nmap ga <Plug>(EasyAlign)]])

-- Lualine {{{2

-- local lualine = require("lualine")

-- lualine.setup({
--   options = {
--     theme = "catppuccin",
--   },
--   sections = {
--     lualine_x = { "g:metals_status", "encoding", "fileformat", "filetype" },
--   },
-- })

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
}

-- metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = { prefix = "" },
-- })

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- For DAP.
metals_config.on_attach = function(_, _)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- -- Make the CodeLens color not the same color as the regular code.
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   command = "hi! link LspCodeLens CursorLine",
-- })

-- Projectionist {{{2

vim.g.projectionist_heuristics = {
  ["*.markdown|*.md"] = {
    ["*.md"] = { dispatch = "open -a 'Marked 2.app' {file}" },
    ["*.markdown"] = { dispatch = "open -a 'Marked 2.app' {file}" },
  },
  ["package.json"] = {
    ["README.md"] = { type = "doc" },
    ["*"] = {
      console = "node",
      make = "npm",
      start = "npm start",
    },
    ["lib/*.js"] = {
      type = "src",
      alternate = "test/{}.js",
    },
    ["test/*.js"] = {
      type = "test",
      alternate = "lib/{}.js",
      dispatch = "yarn test {}",
    },
    ["package.json"] = { type = "package" },
  },
  ["Cargo.toml"] = {
    ["README.md"] = { type = "doc" },
    ["src/*.rs"] = {
      type = "src",
      alternate = "tests/{}.rs",
    },
    ["tests/*.rs"] = {
      type = "test",
      alternate = "src/{}.rs",
      dispatch = "cargo test {}",
    },
    ["benchmarks/*.rs"] = { type = "bench" },
    ["Cargo.toml"] = { type = "config" },
  },
  ["build.sbt"] = {
    ["README.md"] = { type = "doc" },
    ["*"] = {
      console = "bloop-jvm console",
      make = "bloop-jvm compile",
      start = "bloop-jvm run",
    },
    ["src/main/scala/*.scala"] = {
      alternate = "src/test/scala/{}Test.scala",
      type = "src",
    },
    ["src/test/scala/*Test.scala"] = {
      alternate = "src/main/scala/{}.scala",
      type = "test",
      dispatch = "bloop-jvm test --no-color -o {dot}Test",
    },
    ["build.sbt"] = { type = "config" },
    ["*.sbt"] = { type = "config" },
  },
}

-- Rhubarb {{{2

vim.g["github_enterprise_urls"] = { "https://code.corp.creditkarma.com" }


-- Treesitter {{{2

require("nvim-treesitter.configs").setup({
  -- Needed for Treesitter playground
  playground = { enabled = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = {
    "bash",
    "c",
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
    "python",
    "regex",
    "rust",
    "scala",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = { enable = true },
})

-- UndoTree {{{2

vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")

-- Vista {{{2

vim.g["vista_icon_indent"] = { "╰─▸ ", "├─▸ " }
vim.g["vista_default_executive"] = "nvim_lsp"
vim.g["vista#renderer#enable_icon"] = 1

vim.keymap.set("n", "<leader>t", ":<C-u>Vista!!<CR>")

-- Lsp + Lspconfig {{{2

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
require("lspconfig").lua_ls.setup {
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

-- vim: set foldlevel=0 textwidth=72:
