require("tokyonight").setup({
  on_colors = function(colors)
    colors.bg = "#282c34" -- gunmetal
  end,
})
vim.cmd([[colorscheme tokyonight-moon]])
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" })
