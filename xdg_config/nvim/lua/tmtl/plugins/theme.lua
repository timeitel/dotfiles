local M = {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = {
      on_colors = function(colors)
        colors.bg = "#282c34" -- gunmetal
      end,
    },
  },

  "nvim-lualine/lualine.nvim",
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = {
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
