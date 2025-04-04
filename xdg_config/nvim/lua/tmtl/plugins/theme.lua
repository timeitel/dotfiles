local M = {
  "nvim-tree/nvim-web-devicons",
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("kanagawa").setup({
        keywordStyle = { italic = false },
        background = {
          dark = "dragon",
        },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "NONE",
                float = { bg = "NONE", bg_border = "NONE" },
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
          }
        end,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}

return M
