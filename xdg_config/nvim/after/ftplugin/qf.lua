local map = require("tmtl.utils").map

map("n", "l", "<Cr>", { desc = "Open item", buffer = true })

vim.schedule(function()
  vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
end)
