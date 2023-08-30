return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").git_files() end },
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
    }
  }
}
