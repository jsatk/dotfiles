return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    theme = "auto",
    sections = {
      lualine_x = { 'g:metals_status', 'encoding', 'fileformat', 'filetype' },
    }
  }
}
