local map = Utils.map

map("n", "q", function()
  vim.cmd([[cclose]])
end, { desc = "Close quickfix list", buffer = true })
