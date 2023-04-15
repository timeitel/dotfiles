local map = require("tmtl.utils").map

map("n", "<leader><leader>fs", function()
  require("telescope").extensions.possession.list()
end, { desc = "[S]ession - list" })

map("n", "<leader>ss", function()
  vim.fn.feedkeys(":SSave ")
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-j>"'))
end, { desc = "[S]ession [S]ave" })

map("n", "<leader>sl", function()
  vim.cmd([[%bd!|e#]])
  vim.cmd([[SLoad]])
end, { desc = "[S]ession [L]oad - previous session" })

map("n", "<leader>sd", function()
  vim.fn.feedkeys(":SDelete ")
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-j>"'))
end, { desc = "[S]ession [D]elete - current" })
