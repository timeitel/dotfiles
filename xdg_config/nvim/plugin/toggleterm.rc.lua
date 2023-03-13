local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end
local map = require("tmtl.utils").map

-- prefix terminal number befor toggle open for multiple terminals
toggleterm.setup({
  open_mapping = [[<C-;>]],
  direction = "float",
  float_opts = {
    border = "curved",
  },
})

map("n", "<leader>rt", function()
  vim.cmd([[TermExec cmd="npm run type-check"]])
end, { desc = "[R]un [T]ypecheck" })

local group = vim.api.nvim_create_augroup("ToggleTermGroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "UnceptionEditRequestReceived",
  callback = function()
    toggleterm.toggle()
  end,
  group = group,
})
