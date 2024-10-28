vim.keymap.set("n", "m", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1]
  require("harpoon"):list():select(row)
end, { desc = "Open filen", buffer = 0 })
