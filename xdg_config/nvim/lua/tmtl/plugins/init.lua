local M = {
  "RishabhRD/nvim-cheat.sh",
  "RishabhRD/popfix",
  "ThePrimeagen/harpoon",
  "akinsho/toggleterm.nvim",
  "bkad/CamelCaseMotion",
  "ggandor/leap.nvim",
  "inkarkat/vim-ReplaceWithRegister",
  "nat-418/boole.nvim",
  "rcarriga/nvim-notify",
  "sQVe/sort.nvim",
  "smjonas/live-command.nvim",
  "tpope/vim-commentary",
  "windwp/nvim-autopairs",
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
}

return M
