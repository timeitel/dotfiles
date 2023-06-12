local map = require("tmtl.utils").map

map("n", "go;", function()
  vim.cmd([[10ToggleTerm size=80 direction=vertical]])
end, { desc = "[G]o to terminal - vsplit" })

map("n", "<C-;>", function()
  vim.cmd([[9ToggleTerm direction=float]])
end, { desc = "Toggle terminal - float" })
