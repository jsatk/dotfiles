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
    -- Treesitter's indentexpr returns 0 for wrapped bullet continuations,
    -- which breaks `gw`/`gq` on markdown lists — wrapped text lands at col 1
    -- instead of aligning with the text after `* `. Falling back to no
    -- indentexpr lets `formatoptions+=n` + `formatlistpat` handle alignment.
    indent = { disable = { "markdown" } },
  },
}
