local map = vim.keymap.set
local k = vim.keycode

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("n", "{", "[{^", { desc = "Jump to start of enclosing function" })
map("n", "}", "]}", { desc = "Jump to end of enclosing function" })

map("n", "'", "`", { desc = "Jump to mark - always go to column instead of just first non-blank" })

map("n", "'i", "'.", { desc = "Jump to line of last edit - alias" })

map("c", "<C-a>", function()
  vim.api.nvim_input("<C-b>")
  vim.cmd("redraw")
end, { desc = "Linux navigation - start of line" })
map("c", "<M-b>", function()
  vim.fn.feedkeys(k("<S-Left>"))
  vim.cmd("redraws")
end)
map("c", "<M-f>", function()
  vim.fn.feedkeys(k("<S-Right>"))
  vim.cmd("redraws")
end)
map("c", "<M-h>", function()
  vim.fn.feedkeys(k("<Left>"))
  vim.cmd("redraws")
end)
map("c", "<M-l>", function()
  vim.fn.feedkeys(k("<Right>"))
  vim.cmd("redraws")
end)
map("c", "<C-l>", function()
  vim.fn.feedkeys(k("<Enter>"))
end)

map("i", "<Tab>", "<Right>", { desc = "Cursor right" })
map("i", "<C-f>", "<Right>", { desc = "Linux navigation - cursor right" })
map("i", "<C-b>", "<Left>", { desc = "Linux navigation - Cursor left" })
map("i", "<C-d>", "<Esc>lxi", { desc = "Linux navigation - delete word right" })
map("i", "<C-u>", "<Esc>cc", { desc = "Linux navigation - delete line" })
map("i", "<C-a>", "<Esc>I", { desc = "Linux navigation - start of line" })
map("i", "<C-e>", "<Esc>A", { desc = "Linux navigation - end of line" })

map({ "n", "v" }, "j", "gj", { desc = "Down one line, including wrapped lines" })
map({ "n", "v" }, "k", "gk", { desc = "Up one line, including wrapped lines" })
map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
map("n", "<C-i>", "<C-i>", { desc = "Re-map since mapping <Tab> loses <C-i>" })

map("n", "n", "nzz", { desc = "Next search match" })
map("n", "*", "*zz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
map("n", "#", "#zz", { desc = "Previous search match" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "[B]uffer delete [A]ll" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "[B]uffer [N]ew" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "[B]uffer delete [O]thers" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "[B]uffer - next" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "[B]uffer - previous" })
map({ "n", "i" }, "<C-s>", "<cmd>silent w<cr>", { desc = "[B]uffer - save" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "[T]ab - next" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "[T]ab - previous" })

map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "[Q]uickfix [L]ist - show" })
map("n", "<leader>qq", "<cmd>cclose<cr>", { desc = "[Q]uickfix List - [Q]uit" })

map("n", "gof", function()
  vim.cmd([[only]])
  vim.cmd([[vs]])
  vim.fn.feedkeys("gf")
end, { desc = "[G]o to [F]ile in vertical split" })
