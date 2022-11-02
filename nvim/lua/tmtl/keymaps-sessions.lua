local map = Utils.map

map("n", "<leader>fs", function()
  require("telescope").extensions.possession.list()
end, { desc = "Session - list" })

map("n", "<leader>ss", ":SSave ", { desc = "Session - save" })

map("n", "<leader>sl", function()
  vim.cmd([[SLoad]])
end, { desc = "Session - load last" })

map("n", "<leader>sd", function()
  vim.cmd([[SDelete]])
end, { desc = "Session - delete current" })
