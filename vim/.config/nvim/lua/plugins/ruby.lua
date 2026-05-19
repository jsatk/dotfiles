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
          -- LazyVim's ruby extra (via nvim-lspconfig) defaults to invoking
          -- Mason's `srb` binary at ~/.local/share/nvim/mason/packages/sorbet/...
          -- That binary runs inside Mason's gem environment, not the project's
          -- bundle. When Sorbet's startup tries to materialize Gemfile.lock
          -- against that gem env, Bundler raises GemNotFound for project gems
          -- (payroll_building_blocks, form_generator, etc.) and the LSP exits
          -- with code 11 before serving anything. Symptom: `Client sorbet quit
          -- with exit code 11 and signal 0` notification on open.
          -- Use the project's bin/srb binstub instead — it shells out to
          -- `bundle exec srb`, so it sees every project gem. Same shape as
          -- ruby-lsp's bundled RuboCop addon. Relative path resolves against
          -- root_dir below, so it works in every git worktree of zenpayroll.
          cmd = { "bin/srb", "tc", "--lsp", "--disable-watchman" },
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

      -- Bypass mason-lspconfig's automatic_enable AND `vim.lsp.enable`'s own
      -- autocmd for ruby_lsp and sorbet.
      --
      -- Two-part bug:
      --
      -- 1. mason-lspconfig auto-enables every Mason-installed LSP unless
      --    `automatic_enable.exclude` contains it. LazyVim builds the exclude
      --    list only from servers marked `enabled = false`; servers it
      --    enables via lang extras (e.g. ruby_lsp) are NOT excluded. To
      --    suppress that, returning `true` from `opts.setup[server]` adds the
      --    server to mason_exclude (lazyvim/plugins/lsp/init.lua:259).
      --
      -- 2. The deeper issue. `vim.lsp.enable(name)` registers a FileType
      --    autocmd that calls vim.lsp.start. On cold startup, lazy.nvim's
      --    lazy-loading replays FileType events via nvim_exec_autocmds AND
      --    Neovim's native filetype.lua dispatches FileType natively. Both
      --    fire 10–20ms apart through the same autocmd. `vim.lsp.start`'s
      --    internal reuse_client check races against async client init —
      --    second fire doesn't yet see the first client as "active" → two
      --    identical ruby_lsp clients attach to the same buffer. Symptoms:
      --    duplicate clients in `:checkhealth vim.lsp`, position-encoding
      --    warning, `K` hover returns empty.
      --
      -- Fix: register the FileType autocmd ourselves with a buffer-local
      -- guard so the second fire becomes a no-op. Done in a helper since the
      -- same race affects sorbet (same root file, same filetype).
      --
      -- Confirmed empirically 2026-05-19: removing this block instantly
      -- reproduces the duplicate ruby_lsp on startup.
      setup = (function()
        -- Resolve function-form `root_dir` or `root_markers` and then
        -- call vim.lsp.start. vim.lsp.enable's autocmd does this dance
        -- internally (Neovim 0.12 runtime/lua/vim/lsp.lua:548-558) but
        -- vim.lsp.start does NOT — it passes the function through,
        -- leaving the client with `client.root_dir = <function>` which
        -- downstream LazyVim code (lazyvim/util/root.lua:46) tries to
        -- use as a string and crashes lualine. And without resolving
        -- root_markers, ruby_lsp (which uses { "Gemfile", ".git" })
        -- ends up with root_dir=nil. Mirror Neovim's logic here.
        local function start_with_resolved_root(bufnr, config)
          config = vim.deepcopy(config)
          if type(config.root_dir) == "function" then
            config.root_dir(bufnr, function(root_dir)
              if not root_dir then return end
              config.root_dir = root_dir
              vim.schedule(function()
                vim.lsp.start(config, { bufnr = bufnr })
              end)
            end)
          else
            if not config.root_dir and config.root_markers then
              config.root_dir = vim.fs.root(bufnr, config.root_markers)
            end
            vim.lsp.start(config, { bufnr = bufnr })
          end
        end

        local function enable_with_guard(server, filetypes)
          return function(_, sopts)
            vim.lsp.config(server, sopts)
            local guard_key = "_" .. server .. "_started"
            vim.api.nvim_create_autocmd("FileType", {
              pattern = filetypes,
              callback = function(args)
                if vim.b[args.buf][guard_key] then return end
                vim.b[args.buf][guard_key] = true
                start_with_resolved_root(args.buf, vim.lsp.config[server])
              end,
            })
            return true -- adds to LazyVim's mason_exclude
          end
        end

        return {
          ruby_lsp = enable_with_guard("ruby_lsp", { "ruby", "eruby" }),
          sorbet = enable_with_guard("sorbet", { "ruby" }),
        }
      end)(),
    },
  },

  -- :A jumps between a Ruby file and its spec (and :AV / :AS / :AT for
  -- split variants). Lazy-loaded on Ruby/eruby buffers so it doesn't run
  -- its Rails-detection on every startup.
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },

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
