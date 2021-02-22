-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- The plugins, alphabetically sorted
  use {'ap/vim-css-color', opt = true, ft = {'css', 'scss', 'sass', 'less'}}
  use {'dag/vim-fish', opt = true, ft = 'fish'}
  use 'glepnir/galaxyline.nvim'
  use {'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}}}
  use 'joshdick/onedark.vim'
  use 'junegunn/fzf' -- TODO: Figure out how to do `fzf#install()` as a `run` hook.
  use 'junegunn/fzf.vim'
  use {'junegunn/goyo.vim', opt = true, ft = {'markdown', 'tex'}}
  use 'junegunn/gv.vim'
  use 'junegunn/vim-easy-align'
  use 'junegunn/vim-peekaboo'
  use 'kyazdani42/nvim-web-devicons'
  use 'liuchengxu/vista.vim'
  use 'nvim-treesitter/nvim-treesitter'
  use {'scalameta/nvim-metals', opt = true, ft = {'sbt', 'scala'}}
  use 'sheerun/vim-polyglot'
  use 'sjl/gundo.vim'
  use 'stsewd/fzf-checkout.vim'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dadbod'
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-jdaddy'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use {'tpope/vim-scriptease', opt = true, ft = 'vim'}
  use 'tpope/vim-sensible'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'tpope/vim-tbone'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
end)
