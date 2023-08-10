-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle folds with <Space>
vim.keymap.set("n", "<Space>", "za")
vim.keymap.set("v", "<Space>", "za")

-- zG to add to the local dict (vanilla zG is useless anyway).
vim.keymap.set("n", "zG", "2zg")

-- I can't ever remember digraph codes.
vim.keymap.set("i", "<c-k><c-k>", [[<esc>:help digraph-table<cr>]])

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Enable folding in Markdown.
vim.g.markdown_folding = 1

-- Metals commands in Telescope.
vim.keymap.set("n", "<leader>fm", require("telescope").extensions.metals.commands)
