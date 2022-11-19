return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use("nvim-telescope/telescope-file-browser.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Completion
  use("L3MON4D3/LuaSnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lsp-document-symbol")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("tamago324/cmp-zsh")
  use("onsails/lspkind-nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0", -- breaking changes to highlight tokens
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use({ "nvim-treesitter/nvim-treesitter-context" })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } })
  use({ "bobrown101/git-blame.nvim" })

  -- 10000x developer
  use("lewis6991/impatient.nvim")
  use("bkad/CamelCaseMotion")
  use("inkarkat/vim-ReplaceWithRegister")
  use("michaeljsmith/vim-indent-object")
  use("tpope/vim-commentary")
  use({
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  })
  use("ThePrimeagen/harpoon")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use("karb94/neoscroll.nvim")
  use("akinsho/toggleterm.nvim")
  use("ggandor/leap.nvim")
  use({
    "jedrzejboczar/possession.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Styling
  use("monsonjeremy/onedark.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("nvim-lualine/lualine.nvim")
  use("j-hui/fidget.nvim")
end)
