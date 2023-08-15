local gunmetal = "#282c34"

local M = {
  "nvim-tree/nvim-web-devicons",
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("kanagawa").setup({
        statementStyle = { bold = false },
        colors = {
          palette = {
            sumiInk4 = "#33343D",
          },
          theme = {
            wave = {
              ui = {
                bg = gunmetal,
                bg_gutter = "none",
                float = { bg = gunmetal, bg_border = gunmetal },
              },
            },
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
              bg = colors.palette.oldWhite,
            },
            QuickFixLine = {
              bg = colors.palette.sumiInk3,
            },
            CursorLine = { bg = "#33343D" },
            DapBreakpoint = { fg = colors.palette.peachRed },
          }
        end,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
}

return M
