local M = {
  "RishabhRD/popfix",
  "ThePrimeagen/harpoon",
  "bkad/CamelCaseMotion",
  "inkarkat/vim-ReplaceWithRegister",
  "tpope/vim-commentary",
  "arkav/lualine-lsp-progress",
  {
    "sQVe/sort.nvim",
    config = function()
      local map = require("tmtl.utils").map
      map("v", "gos", "<Esc><Cmd>Sort<CR>", { desc = "[S]ort visual selection" })
      map("n", "gos", "vi{<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside curly brace" })
      map("n", "go[", "vi[<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside bracket `[`" })
    end,
  },
  {
    "RishabhRD/nvim-cheat.sh",
    config = function()
      local map = require("tmtl.utils").map
      map("n", "<leader>cr", function()
        vim.cmd([[Cheat rust ]])
      end, { desc = "[C]heatsheet - [R]ust" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
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
      require("nvim-surround").setup({
        aliases = {
          ["b"] = ")",
          ["c"] = "}",
          ["r"] = "]",
          ["q"] = '"',
          ["l"] = '`',
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
      })
    end,
  },
  {
    "jedrzejboczar/possession.nvim",
    opts = {
      commands = {
        save = "SSave",
        load = "SLoad",
        delete = "SDelete",
        list = "SList",
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "samjwill/nvim-unception",
    config = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
  },
}

return M
