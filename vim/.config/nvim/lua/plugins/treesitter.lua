return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- Merges w/ the default list that comes w/ LazyVim.
    -- See: https://www.lazyvim.org/plugins/treesitter
    ensure_installed = {
      "commonlisp",
      "css",
      "embedded_template",
      "latex",
      "ruby",
      "scss",
      "svelte",
      "typst",
      "vue",
    },
  },
}
