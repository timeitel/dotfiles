local map = require("tmtl.utils").map

map("n", "q", function()
  vim.cmd([[cclose]])
end, { desc = "Close quickfix list", buffer = true })
