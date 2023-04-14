local M = {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  -- LSP
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",

  -- Completion
  "L3MON4D3/LuaSnip",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "tamago324/cmp-zsh",
  "onsails/lspkind-nvim",

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "kiyoon/treesitter-indent-object.nvim",

  -- Git
  "lewis6991/gitsigns.nvim",
  { "TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } },
  "bobrown101/git-blame.nvim",

  -- Notifications
  "rcarriga/nvim-notify",

  -- 10000x developer
  "lewis6991/impatient.nvim",
  "bkad/CamelCaseMotion",
  "inkarkat/vim-ReplaceWithRegister",
  "tpope/vim-commentary",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  "ThePrimeagen/harpoon",
  "windwp/nvim-autopairs",
  "karb94/neoscroll.nvim",
  "akinsho/toggleterm.nvim",
  "ggandor/leap.nvim",
  {
    "jedrzejboczar/possession.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "smjonas/live-command.nvim",
  "RishabhRD/popfix",
  "RishabhRD/nvim-cheat.sh",
  {
    "samjwill/nvim-unception",
    config = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
  },
  "sQVe/sort.nvim",
  "nat-418/boole.nvim",

  -- Styling
  -- "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "folke/tokyonight.nvim",
  { "akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons" },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
}

return M
