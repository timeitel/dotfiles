local gunmetal = "#282c34"
local M = {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('kanagawa').setup({
        statementStyle = { bold = false },
        colors = {
          theme = {
            wave = {
              ui = { bg = gunmetal, bg_gutter = "none",
                float = { bg = gunmetal, bg_border = gunmetal, },
              }
            }
          },
        },
        overrides = function(colors)
          return {
            DiffChange = {
              bg = "#383739",
            },
            DiagnosticError = { fg = colors.palette.peachRed },
            DiagnosticSignError = { fg = colors.palette.peachRed },
            DiagnosticUnderlineError = { sp = colors.palette.peachRed },
            ["@lsp.typemod.function.readonly"] = { bold = false },
            Operator = { bold = true },
            Boolean = { bold = false },
            DiffviewFilePanelSelected = {
              fg = colors.palette.sumiInk2,
              bg = colors.palette.oldWhite
            },
            QuickFixLine = {
              bg = colors.palette.sumiInk3
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
