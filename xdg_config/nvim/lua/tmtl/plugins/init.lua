local M = {
  "ThePrimeagen/harpoon",
  "inkarkat/vim-ReplaceWithRegister",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      triggers_nowait = {},
      plugins = {
        presets = false,
      },
    },
  },
  {
    "sQVe/sort.nvim",
    config = function()
      local map = require("tmtl.utils").map
      map("v", "gos", "<Esc><Cmd>Sort<CR>", { desc = "[S]ort visual selection" })
      map("n", "gos", "vi{<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside curly brace" })
      map("n", "go[", "vi[<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside bracket `[`" })
      map("n", "go\"", "vi\"<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside quotes `\"`" })
      map("n", "go'", "vi'<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside single quotes `'`" })

      require("sort").setup({
        delimiters = {
          ',',
          '|',
          ';',
          -- ':', -- used for tailwind psuedo classes
          's', -- Space
          't' -- Tab
        }
      })
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
    opts = {
      aliases = {
        ["b"] = ")",
        ["c"] = "}",
        ["C"] = "}",
        ["r"] = "]",
        ["q"] = '"',
        ["l"] = "`",
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },
  {
    'bloznelis/before.nvim',
    config = function()
      local map = require("tmtl.utils").map
      local before = require('before')
      before.setup()

      map("n", "[c", before.jump_to_last_edit, { desc = "Jump to last [C]hange" })
      map("n", "]c", before.jump_to_next_edit, { desc = "Jump to next [C]hange" })
    end
  }
}

return M
