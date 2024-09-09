return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        metals = {
          init_options = {
            statusBarProvider = "on",
          },
        },
      },
    },
  },
}
