local ok, neoscroll = pcall(require, "neoscroll")
if not ok then
  return
end

neoscroll.setup({
  mappings = { "<C-u>", "<C-d>" },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "30" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "30" } }
require("neoscroll.config").set_mappings(t)
