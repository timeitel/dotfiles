local map = require("tmtl.utils").map

-- TODO: fix for scopes window
map("n", "<C-l>", function()
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<cr>"'))
end, { desc = "Toggle node", buffer = true })
