local map = require("tmtl.utils").map

map("n", "q", function()
  vim.cmd([[cclose]])
end, { desc = "Close quickfix list", buffer = true })

local function color()
  vim.defer_fn(function()
    vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
  end, 20)
end

color()
