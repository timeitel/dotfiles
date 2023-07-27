local map = require("tmtl.utils").map

map("n", "<C-l>", function()
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<cr>"'))
end, { desc = "Toggle node", buffer = true })
