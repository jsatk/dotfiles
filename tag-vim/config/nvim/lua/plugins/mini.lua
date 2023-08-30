return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function(_, _)
      require("mini.surround").setup()

      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      require("mini.comment").setup()
      require("mini.basics").setup()
      require("mini.align").setup()
      require("mini.statusline").setup()
      require("mini.starter").setup()
    end
  },
}
