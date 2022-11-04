local map = Utils.map

vim.g.mapleader = " "
vim.g.camelcasemotion_key = "<leader>"

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("i", "kj", "<ESC>", { desc = "Escape" })
map("i", "<A-l>", "<Right>", { desc = "Cursor right" })
map("i", "<A-h>", "<Left>", { desc = "Cursor left" })

map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump - back" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump - forward" })
map("n", "n", "nzz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
map("n", "Y", "yy", { desc = "Yank line" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

map("n", "<leader>sp", function()
  local inp = vim.fn.input("What would you like to name the current snapshot? ")
  if inp == nil or inp == "" then
    return
  end
  vim.cmd(string.format("PackerSnapshot %s", inp))
  vim.cmd([[PackerSync]])
end, { desc = "Plugins - sync" })

-- Tabs (buffers)
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "Buffer - delete all" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Buffer - delete all others" })
map("n", "zx", "<cmd>update<cr>", { desc = "Buffer - save" })

-- Quick fix list
map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "Quickfix list - show" })
map("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "Quickfix list - next" })
map("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "Quickfix list - previous" })

map("n", "<leader>gr", function()
  vim.api.nvim_feedkeys("gg/export\nWW", "n", true)
  vim.fn.feedkeys("gr")
end, { desc = "Lsp - file references" })

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[xmap <Leader>r <Plug>ReplaceWithRegisterVisual]])
vim.cmd([[nmap <Leader>R <Plug>ReplaceWithRegisterLine]])
