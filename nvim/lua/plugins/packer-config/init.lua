return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'gruvbox-community/gruvbox'

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-document-symbol"
  use "saadparwaiz1/cmp_luasnip"
  use "tamago324/cmp-zsh"
end)
