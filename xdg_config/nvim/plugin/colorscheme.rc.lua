local ok, tokyo_night = pcall(require, "tokyonight")
if not ok then
  return
end

tokyo_night.setup({
  on_colors = function(colors)
    colors.bg = "#282c34" -- gunmetal
  end,
})
-- vim.cmd([[colorscheme tokyonight-moon]])
