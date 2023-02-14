local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

-- prefix terminal number befor toggle open for multiple terminals
toggleterm.setup({
  open_mapping = [[<C-;>]],
  direction = "float",
  float_opts = {
    border = "curved",
  },
})
