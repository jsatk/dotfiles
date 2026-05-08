-- I had to do some custom stuff in here to get things to play nice with
-- Gusto's quite impressive Ruby setup, which includes a custom RuboCop config
-- and Sorbet with a nonstandard project layout. See comments below for
-- details.

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LazyVim's ruby extra enables a standalone `rubocop` LSP by default,
        -- which uses Mason's rubocop (1.86.1) — but Mason's gem set doesn't
        -- include zenpayroll's rubocop plugins (rubocop-capybara, rubocop-gusto,
        -- etc.), so it crashes with "cannot load such file -- rubocop-capybara".
        -- Meanwhile ruby-lsp already activates its built-in RuboCop addon against
        -- the project's bundled rubocop (1.84.2), which is the correct one.
        -- Disable the standalone LSP; ruby-lsp's addon does the job.
        rubocop = { enabled = false },

        -- Sorbet's default root_markers are { "Gemfile", ".git" }, which makes
        -- it attach to any git repo containing a Ruby file (e.g. ~/dotfiles via
        -- the Brewfile's filetype=ruby modeline) and crash because there's no
        -- sorbet/config. Overriding root_markers via opts is unreliable —
        -- vim.lsp.config deep-merges arrays per-index, so the leftover ".git"
        -- at index 2 still matches. Use root_dir (function) instead, which
        -- fully replaces the resolver and only attaches when sorbet/config is
        -- found upward from the buffer.
        sorbet = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local match = vim.fs.find({ "sorbet/config" }, {
              upward = true,
              path = vim.fs.dirname(fname),
            })[1]
            if match then
              -- match = .../<root>/sorbet/config; project root is its grandparent
              on_dir(vim.fs.dirname(vim.fs.dirname(match)))
            end
            -- not calling on_dir leaves the client unattached (intended)
          end,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- LazyVim's ruby extra sets this to { "rubocop" }, which makes conform
        -- spawn `rubocop` from PATH — and PATH puts Mason's broken
        -- ~/.local/share/nvim/mason/bin/rubocop first, hitting the same
        -- "cannot load -- rubocop-capybara" crash as the standalone LSP did.
        -- Use a function (not an empty list) to fully replace the original;
        -- vim.tbl_deep_extend merges arrays per-index, so { } would NOT
        -- override { "rubocop" }. With no conform formatter for ruby and
        -- LazyVim's `lsp_format = "fallback"`, formatting falls through to
        -- ruby-lsp, whose RuboCop addon runs the project's bundled rubocop.
        ruby = function()
          return {}
        end,
      },
    },
  },
}
