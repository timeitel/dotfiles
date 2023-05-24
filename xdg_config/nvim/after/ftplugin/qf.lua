local map = require("tmtl.utils").map

map("n", "q", function()
  vim.cmd([[cclose]])
end, { desc = "Close quickfix list", buffer = true })

map("n", "l", "<Cr>", { desc = "Open item", buffer = true })

vim.schedule(function()
  vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
end)
