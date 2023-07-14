local map = require("tmtl.utils").map

map("n", "q", function()
  vim.cmd([[wincmd c]])
end, { desc = "Close toggleterm", buffer = true })
