return {
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
    config = function(_, _)
      -- This section contains Neovim LSP settings as well as settings for the
      -- Lspconfig plugin.  I know it's not "pure" in an organizational sense,
      -- but this felt correct and logical; especially since Neovim's LSP is
      -- not listed in :options and – as stated in my giant preamble – I've
      -- chosen to organize the settings in this file to mirror the order they
      -- are in in :options.  So yeah, both are mixed in here. ¯\_(ツ)_/¯

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
      require("lspconfig").luals.setup {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }
      require("lspconfig").terraformls.setup {}
      require("lspconfig").tsserver.setup {}
      require("lspconfig").vimls.setup {}
    end,
  },
  --   opts = {
  --     -- options for vim.diagnostic.config()
  --     diagnostics = {
  --       underline = true,
  --       update_in_insert = false,
  --       virtual_text = {
  --         spacing = 4,
  --         source = "if_many",
  --         prefix = "●",
  --         -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
  --         -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
  --         -- prefix = "icons",
  --       },
  --       severity_sort = true,
  --     },
  --     -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  --     -- Be aware that you also will need to properly configure your LSP server to
  --     -- provide the inlay hints.
  --     inlay_hints = {
  --       enabled = false,
  --     },
  --     -- add any global capabilities here
  --     capabilities = {},
  --     -- Automatically format on save
  --     autoformat = true,
  --     -- Enable this to show formatters used in a notification
  --     -- Useful for debugging formatter issues
  --     format_notify = false,
  --     -- options for vim.lsp.buf.format
  --     -- `bufnr` and `filter` is handled by the LazyVim formatter,
  --     -- but can be also overridden when specified
  --     format = {
  --       formatting_options = nil,
  --       timeout_ms = nil,
  --     },
  --     -- LSP Server Settings
  --     ---@type lspconfig.options
  --     servers = {
  --       bashls = {},
  --       dockerls = {},
  --       gopls = {},
  --       graphql = {},
  --       rust_analyzer = {},
  --       terraformls = {},
  --       tsserver = {},
  --       vimls = {},
  --       jsonls = {},
  --       lua_ls = {
  --         -- mason = false, -- set to false if you don't want this server to be installed with mason
  --         -- Use this to add any additional keymaps
  --         -- for specific lsp servers
  --         ---@type LazyKeys[]
  --         -- keys = {},
  --         settings = {
  --           Lua = {
  --             workspace = {
  --               checkThirdParty = false,
  --             },
  --             completion = {
  --               callSnippet = "Replace",
  --             },
  --           },
  --         },
  --       },
  --     },
  --     -- you can do any additional lsp server setup here
  --     -- return true if you don't want this server to be setup with lspconfig
  --     ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --     setup = {
  --       -- example to setup with typescript.nvim
  --       -- tsserver = function(_, opts)
  --       --   require("typescript").setup({ server = opts })
  --       --   return true
  --       -- end,
  --       -- Specify * to use this function as a fallback for any server
  --       -- ["*"] = function(server, opts) end,
  --     },
  --   },
  -- },
}
