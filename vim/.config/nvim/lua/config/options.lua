-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- Enable folding in Markdown.
vim.g.markdown_folding = 1

-- Collapse all folds when opening a file.
vim.opt.foldlevelstart = 0

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
-- Use `vim.opt` (= `:set`), not `vim.opt_global` (= `:setglobal`).
-- `spellfile` is local-to-buffer; `:setglobal` only sets the default
-- for *future* buffers, and when a file is passed on the nvim command
-- line (e.g. via the `ep` fish function: `nvim '+$' ~/.plan`) the
-- buffer is created before `init.lua` runs and never picks up the
-- global default. `:set` sets both the global default AND the current
-- buffer's local value, so the cmdline-loaded buffer gets it directly.
vim.opt.spellfile = {
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
