local ok, tokyo_night = pcall(require, "tokyonight")
if not ok then
  return
end

tokyo_night.setup({
  on_colors = function(colors)
    colors.bg = "#282c34" -- gunmetal
  end,
})
vim.cmd([[colorscheme tokyonight-moon]])

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#363c58" })
-- vim.api.nvim_set_hl(0, "DiffviewStatusAdded", { guibg = "#282c34" })
-- vim.api.nvim_set_hl(0, "DiffviewStatusDeleted", { guibg = "#282c34" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#323a5a" })
vim.api.nvim_set_hl(0, "Folded", { bg = "#363c58", fg = "#7a88cf" })
