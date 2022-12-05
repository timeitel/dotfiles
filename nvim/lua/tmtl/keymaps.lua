local map = Utils.map

vim.g.mapleader = " "
vim.g.camelcasemotion_key = "<leader>"

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("v", "p", "P", { desc = "Keep register on visual paste" })
map("v", "P", "p", { desc = "Replace register on visual paste" })

map("i", "kj", "<ESC>", { desc = "Escape" })
map("i", "<A-l>", "<Right>", { desc = "Cursor right" })
map("i", "<A-h>", "<Left>", { desc = "Cursor left" })

map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
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

map("n", "<leader>T", function()
  vim.fn.feedkeys("iTODO: ")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<esc>"'), "n", true)
  vim.fn.feedkeys("gccA")
end, { desc = "Insert - TODO comment" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "Buffer - delete all" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Buffer - delete all others" })
map("n", "<leader>bj", "<cmd>bnext<cr>", { desc = "Buffer - next" })
map("n", "<leader>bk", "<cmd>bprevious<cr>", { desc = "Buffer - previous" })
map({ "n", "i" }, "<C-s>", "<cmd>update<cr>", { desc = "Buffer - save" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Tab - new" })
map("n", "<leader>tj", "<cmd>tabnext<cr>", { desc = "Tab - next" })
map("n", "<leader>tk", "<cmd>tabprevious<cr>", { desc = "Tab - previous" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Tab - quit" })

-- Quick fix list
map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "Quickfix list - show" })
map("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "Quickfix list - next" })
map("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "Quickfix list - previous" })
map("n", "<leader>qq", "<cmd>cclose<cr>", { desc = "Quickfix list - quit" })

map("n", "<leader>gr", function()
  vim.api.nvim_feedkeys("gg/export\nWW", "n", true)
  vim.fn.feedkeys("gr")
  -- local ts = require("telescope.builtin")
  -- local themes = require("telescope.themes")
  -- ts.lsp_references(themes.get_cursor({ show_line = false, include_declaration = false }))
end, { desc = "Lsp - file references" })

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[xmap <Leader>r <Plug>ReplaceWithRegisterVisual]])
vim.cmd([[nmap <Leader>R <Plug>ReplaceWithRegisterLine]])
