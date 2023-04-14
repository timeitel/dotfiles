local M = {
  "RishabhRD/nvim-cheat.sh",
  "RishabhRD/popfix",
  "ThePrimeagen/harpoon",
  "akinsho/toggleterm.nvim",
  "bkad/CamelCaseMotion",
  "inkarkat/vim-ReplaceWithRegister",
  "rcarriga/nvim-notify",
  "sQVe/sort.nvim",
  "smjonas/live-command.nvim",
  "tpope/vim-commentary",
  "windwp/nvim-autopairs",
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  { "jedrzejboczar/possession.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
  {
    "nat-418/boole.nvim",
    config = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
    },
  },
}

return M
