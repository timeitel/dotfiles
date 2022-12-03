-- TODO: open current file in term
require("toggleterm").setup({
  open_mapping = [[<C-;>]],
  direction = "float",
  float_opts = {
    border = "curved",
  },
})
