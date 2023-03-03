local map = require("tmtl.utils").map

map("n", "<leader>cr", function()
  vim.cmd([[Cheat rust ]])
end, { desc = "[C]heatsheet - [R]ust" })
