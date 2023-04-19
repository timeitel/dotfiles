local gunmetal = "#282c34"
local M = {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = gunmetal
          colors.bg_float = gunmetal
          colors.border_highlight = colors.fg
          colors.gitSigns.add = colors.green2
          colors.gitSigns.change = "#B79361"
          colors.gitSigns.delete = colors.red
        end,
        on_highlights = function(hl, c)
          hl.CursorLine = {
            bg = "#363c58",
          }
          hl.DiffAdd = {
            bg = "#283c4e",
          }
          hl.DiffDelete = {
            bg = "#38222c",
          }
          hl.DiffChange = {
            bg = "#54524F",
          }
          hl.DiffText = {
            bg = "#70604A"
          }
          local float_border = {
            bg = c.bg,
            fg = c.fg,
          }
          hl.NotifyINFOBorder = float_border
          hl.NotifyTRACEBorder = float_border
          hl.NotifyWARNBorder = float_border
          hl.NotifyBorder = float_border
        end,
      })
      vim.cmd([[colorscheme tokyonight-moon]])
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
