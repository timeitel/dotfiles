local map = require("tmtl.utils").map

-- TODO: fix for scopes window
map("n", "<C-l>", function()
  vim.api.nvim_input("<cr>")
end, { desc = "Toggle node", buffer = true })
