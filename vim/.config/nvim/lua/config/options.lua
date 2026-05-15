-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- Enable folding in Markdown.
vim.g.markdown_folding = 1

-- There are three dictionaries I use for spellchecking:
--
--   /usr/share/dict/words
--   Basic stuff.
--
--   ~/.vim/custom-dictionary.utf-8.add
--   Custom words (like my name).  This is in my (version-controlled) dotfiles.
--
--   ~/.vim-local-dictionary.utf-8.add
--   More custom words.  This is *not* version controlled, so I can stick
--   work stuff in here without leaking internal names and shit.
--
-- Stolen from Steve Losh
vim.opt_global.spellfile = {
  vim.fn.expand("~/.vim/custom-dictionary.utf-8.add"),
  vim.fn.expand("~/.vim-local-dictionary.utf-8.add"),
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fish",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
