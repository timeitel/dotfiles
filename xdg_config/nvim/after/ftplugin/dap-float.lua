local map = require("tmtl.utils").map

map("n", "q", function()
  vim.cmd([[close]])
end, { desc = "Close", buffer = true })
