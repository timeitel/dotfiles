local map = Utils.map

map("n", "<leader>fs", function()
  require("telescope").extensions.possession.list()
end, { desc = "[S]ession - list" })

map("n", "<leader>ss", ":SSave ", { desc = "[S]ession [S]ave" })

map("n", "<leader>sl", function()
  vim.cmd([[SLoad]])
end, { desc = "[S]ession [L]oad - previous session" })

map("n", "<leader>sd", function()
  vim.cmd([[SDelete]])
end, { desc = "[S]ession [D]elete - current" })
