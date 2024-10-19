local neoscroll = require("neoscroll")
local keymap = {
  ["<C-u>"] = function()
    neoscroll.ctrl_u({ duration = 50 })
  end,
  ["<C-d>"] = function()
    neoscroll.ctrl_d({ duration = 50 })
  end,
  ["zt"] = function()
    neoscroll.zt({ half_win_duration = 50 })
  end,
  ["zz"] = function()
    neoscroll.zz({ half_win_duration = 50 })
  end,
  ["zb"] = function()
    neoscroll.zb({ half_win_duration = 50 })
  end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end
