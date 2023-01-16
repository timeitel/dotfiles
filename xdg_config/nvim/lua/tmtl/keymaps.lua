local getVisualSelection = Utils.getVisualSelection

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
map("i", "<C-d>", "<Esc>lcw", { desc = "Delete word right" })

map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump - back" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump - forward" })
map("n", "n", "nzz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
map("n", "Y", "yy", { desc = "Yank line" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })

map("n", "<leader>yd", function()
  local copy_directory_cmd = string.format(':let @+="%s"', vim.fn.expand("%:h"))
  vim.cmd(copy_directory_cmd)
  print("Copied directory to clipboard")
end, { desc = "Copy file directory to clipboard" })
map("n", "<leader>yp", function()
  local copy_directory_cmd = string.format(':let @+="%s"', vim.fn.expand("%"))
  vim.cmd(copy_directory_cmd)
  print("Copied file path to clipboard")
end, { desc = "Copy file path to clipboard" })
map("n", "<leader>yf", function()
  local copy_directory_cmd = string.format(':let @+="%s"', vim.fn.expand("%:t"))
  vim.cmd(copy_directory_cmd)
  print("Copied filename to clipboard")
end, { desc = "Copy filename to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })

map("n", "<leader>sp", function()
  local inp = vim.fn.input("What would you like to name the current snapshot? ")
  if inp == nil or inp == "" then
    return
  end
  vim.cmd(string.format("PackerSnapshot %s", inp))
  vim.cmd([[PackerSync]])
end, { desc = "[S]ync [P]lugins" })

map("n", "<leader>T", function()
  vim.fn.feedkeys("iTODO: ")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<esc>"'), "n", true)
  vim.fn.feedkeys("gccA")
end, { desc = "Insert - [T]ODO comment" })

map("n", "<leader>R", function()
  vim.fn.feedkeys(":%s/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
end, { desc = "[R]eplace in file - word under cursor" })

map("v", "<leader>R", function()
  local text = getVisualSelection()
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<esc>"'), "n", true)
  vim.fn.feedkeys(":%s/" .. text)
end, { desc = "[R]eplace in file - word under cursor" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "[B]uffer - delete [A]ll" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "[B]uffer - delete [O]thers" })
map("n", "<leader>bj", "<cmd>bnext<cr>", { desc = "[B]uffer - next" })
map("n", "<leader>bk", "<cmd>bprevious<cr>", { desc = "[B]uffer - previous" })
map({ "n", "i" }, "<C-s>", "<cmd>update<cr>", { desc = "[B]uffer - save" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
map("n", "<leader>tj", "<cmd>tabnext<cr>", { desc = "[T]ab - next" })
map("n", "<leader>tk", "<cmd>tabprevious<cr>", { desc = "[T]ab - previous" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "[T]ab [Q]uit" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "[T]ab - delete [O]thers" })

-- Quickfix list
map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "[Q]uickfix [L]ist - show" })
map("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "[Q]uickfix List - next" })
map("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "[Q]uickfix List - previous" })
map("n", "<leader>qq", "<cmd>cclose<cr>", { desc = "[Q]uickfix List - [Q]uit" })

map("n", "<leader>gr", function()
  vim.api.nvim_feedkeys("gg/export\nWW", "n", true)
  vim.fn.feedkeys("gr")
  -- local ts = require("telescope.builtin")
  -- local themes = require("telescope.themes")
  -- ts.lsp_references(themes.get_cursor({ show_line = false, include_declaration = false }))
end, { desc = "Lsp - [G]o to file [R]eferences" })

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[xmap <Leader>r <Plug>ReplaceWithRegisterVisual]])
vim.cmd([[nmap <Leader>((( <Plug>ReplaceWithRegisterLine]]) --just unmap
