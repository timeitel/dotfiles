local map = require("tmtl.utils").map

map("n", "<leader>sl", function()
  require("telescope").extensions.possession.list()
end, { desc = "[S]ession - list" })

map("n", "<leader>sa", function()
  vim.fn.feedkeys(":SSave ")
  vim.api.nvim_input("<C-j>")
end, { desc = "[S]ession [A]dd - add current session, either new or override" })

map("n", "<leader>so", function()
  vim.cmd([[%bd!|e#|bd#]])
  vim.cmd([[SLoad]])
end, { desc = "[S]ession [O]pen - previous session" })

map("n", "<leader>sd", function()
  vim.fn.feedkeys(":SDelete ")
  vim.api.nvim_input("<C-j>")
end, { desc = "[S]ession [D]elete - current" })
