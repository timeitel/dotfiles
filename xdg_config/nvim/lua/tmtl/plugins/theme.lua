local gunmetal = "#282c34"
local M = {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('kanagawa').setup({
        colors = {
          theme = {
            wave = {
              ui = { bg = gunmetal, bg_gutter = "none", float = { bg = gunmetal, bg_border = gunmetal, },
              }
            }
          },
        },
        overrides = function()
          return {
            DiffChange = {
              bg = "#383739",
            }
          }
        end,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "tabs",
        buffer_close_icon = "",
        show_duplicate_prefix = false,
        max_name_length = 30,
        always_show_bufferline = false,
      },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
}

return M
