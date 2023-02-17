local assign_to_next_prev = Utils.assign_to_next_prev
local getVisualSelection = Utils.getVisualSelection

local map = Utils.map

vim.g.mapleader = " "
vim.g.camelcasemotion_key = "<leader>"

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("v", "p", "P", { desc = "Keep register on visual paste" })
map("v", "P", "p", { desc = "Replace register on visual paste" })
map("v", "<C-q>", "<Esc>", { desc = "Return to normal mode" })

map("c", "<C-q>", function()
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-u>\\<BS>"'))
end, { desc = "Return to normal mode" })

map("i", "kj", "<Esc>", { desc = "Return to normal mode" })
map("t", "kj", "<C-\\><C-n>", { desc = "Return to normal mode" })
map("i", "<A-l>", "<Right>", { desc = "Cursor right" })
map("i", "<A-h>", "<Left>", { desc = "Cursor left" })
map("i", "<A-j>", "<Down>", { desc = "Cursor down" })
map("i", "<A-k>", "<Up>", { desc = "Cursor up" })
map("i", "<C-d>", "<Esc>lcw", { desc = "Delete word right" })

map({ "n", "v" }, "j", "gj", { desc = "Down one line, including wrapped lines" })
map({ "n", "v" }, "k", "gk", { desc = "Up one line, including wrapped lines" })
map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump - back" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump - forward" })

-- Text search
map("n", "n", "nzz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
-- TODO: also zz with g; and g, and also look into tab for getting out of closing pair
-- TODO: store qf movement into . operation

-- TODO: fix
-- map({ "n", "v" }, "*", function()
--   vim.fn.feedkeys("*")
--   -- vim.defer_fn(function()
--   --   vim.fn.feedkeys("zz")
--   -- end, 10)
-- end, { desc = "Previous search match" })
-- map({ "n", "v" }, "N", "Nzz", { desc = "Previous search match" })

map("n", "Y", "yy", { desc = "Yank line" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })

map("n", "<leader>/", function()
  vim.fn.feedkeys("/\\<\\>")
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<Left>\\<Left>"'))
end, { desc = "Find - exact match" })

map("v", "<leader>/", function()
  local text = getVisualSelection()
  local search = string.format("/\\<%s\\>", text)
  vim.fn.feedkeys(search)
end, { desc = "Find - exact match" })

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

map("n", "<leader>gr", function()
  vim.fn.feedkeys(":%s/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
end, { desc = "[R]eplace in file - word under cursor" })

map("v", "<leader>gr", function()
  local text = getVisualSelection()
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<esc>"'), "n", true)
  vim.fn.feedkeys(":%s/" .. text)
end, { desc = "[R]eplace in file - word under cursor" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "[B]uffer - delete [A]ll" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "[B]uffer - delete [O]thers" })
map("n", "<leader>bj", "<cmd>bnext<cr>", { desc = "[B]uffer - next" })
map("n", "<leader>bk", "<cmd>bprevious<cr>", { desc = "[B]uffer - previous" })
map({ "n", "i" }, "<C-s>", "<cmd>w<cr>", { desc = "[B]uffer - save" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
map("n", "<leader>tj", "<cmd>tabnext<cr>", { desc = "[T]ab - next" })
map("n", "<leader>tk", "<cmd>tabprevious<cr>", { desc = "[T]ab - previous" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "[T]ab [Q]uit" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "[T]ab - delete [O]thers" })

-- Quickfix list
function Goto_QfItem(opts)
	opts = opts or {}
	local prev = opts.prev or false

	if prev then
		vim.cmd([[cprevious]])
	else
		vim.cmd([[cnext]])
	end

	vim.fn.feedkeys("zz")
end

map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "[Q]uickfix [L]ist - show" })

map("n", "<leader>qj", function()
	assign_to_next_prev(Goto_QfItem, function()
		Goto_QfItem({ prev = true })
	end)

	Goto_QfItem()
end, { desc = "[Q]uickfix List - next" })
map("n", "<leader>qk", function()
	assign_to_next_prev(function()
		Goto_QfItem({ prev = true })
	end, Goto_QfItem)

	Goto_QfItem({ prev = true })
end, { desc = "[Q]uickfix List - previous" })
map("n", "<leader>qq", "<cmd>cclose<cr>", { desc = "[Q]uickfix List - [Q]uit" })

-- TODO: find based on treesitter export node
map("n", "<leader>R", function()
  vim.api.nvim_feedkeys("gg/export\nWW", "n", true)
  vim.fn.feedkeys("<leader>r")
end, { desc = "Lsp - [G]o to file [R]eferences" })
-- TODO: a repeat command / action like stage file -> also assign <C-.>
