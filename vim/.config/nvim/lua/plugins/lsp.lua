-- General LSP behavior tweaks that aren't specific to any one language.
-- Language-specific server config (sorbet, ruby_lsp, etc.) lives in the
-- per-language files like `ruby.lua`.

return {
  {
    -- Suppress the "No information available" notification on hover.
    --
    -- vim.lsp.buf.hover() (bound to `K`) queries every attached client
    -- that advertises hoverProvider. When one client has content (e.g.
    -- ruby_lsp on a Ruby stdlib symbol) and another returns empty (e.g.
    -- sorbet on an untyped symbol), the popup AND a redundant
    -- "No information available" notification both fire.
    --
    -- Why this lives on noice, not nvim-lspconfig: LazyVim's UI extra
    -- ships noice.nvim, and noice REPLACES vim.lsp.buf.hover with its
    -- own implementation (noice/lsp/init.lua:20). Wrapping the original
    -- function in an init() callback is futile — noice loads later and
    -- overwrites the wrap. Noice's own implementation calls
    -- vim.notify("No information available") in noice/lsp/hover.lua:13,
    -- gated on Config.options.lsp.hover.silent. Setting that to true is
    -- the canonical path; non-empty hovers still render normally.
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
      },
    },
  },
}
