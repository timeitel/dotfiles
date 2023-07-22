local get_visual_selection = require("tmtl.utils").get_visual_selection
local map = require("tmtl.utils").map
local notify = require("notify")

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })
map("n", "X", "xi", { desc = "Replacement for vanilla 's'" })

map("v", "p", "P", { desc = "Keep register on visual paste" })
map("v", "P", "p", { desc = "Replace register on visual paste" })

map({ "n", "v", }, "q", "<Esc>", { desc = "Return to normal mode" })
map("s", "<C-q>", "<Esc>", { desc = "Return to normal mode" })
map("n", "Q", "q", { desc = "Safer trigger for macro recording" })

map({ "o", "x" }, "<C-q>", "<Esc>", { desc = "Exit operator mode" })
map({ "o", "x" }, "iq", 'i"', { desc = "Operator mode syntax aliases" }) -- [q]uote
map({ "o", "x" }, "aq", 'a"', { desc = "Operator mode syntax aliases" })
map({ "o", "x" }, "is", "i'", { desc = "Operator mode syntax aliases" }) -- [s]ingle quote
map({ "o", "x" }, "as", "a'", { desc = "Operator mode syntax aliases" })
map({ "o", "x" }, "il", "i`", { desc = "Operator mode syntax aliases" }) -- template [l]iteral string
map({ "o", "x" }, "al", "a`", { desc = "Operator mode syntax aliases" })
map({ "o", "x" }, "ir", "i[", { desc = "Operator mode syntax aliases" }) -- [r]ectangular brackets
map({ "o", "x" }, "ar", "a[", { desc = "Operator mode syntax aliases" })
map({ "o", "x" }, "ic", "i{", { desc = "Operator mode syntax aliases" }) -- [c]urly brackets
map({ "o", "x" }, "ac", "a{", { desc = "Operator mode syntax aliases" })

map("c", "<C-q>", function()
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-u>\\<BS>"'))
end, { desc = "Return to normal mode" })

map("i", "kj", "<Esc>", { desc = "Return to normal mode" })
map("t", "kj", "<C-\\><C-n>", { desc = "Return to normal mode" })
map("i", "<C-f>", "<Right>", { desc = "Cursor right" })
map("i", "<C-b>", "<Left>", { desc = "Cursor left" })
map("i", "<C-d>", "<Esc>lcw", { desc = "Delete word right" })

map({ "n", "v" }, "j", "gj", { desc = "Down one line, including wrapped lines" })
map({ "n", "v" }, "k", "gk", { desc = "Up one line, including wrapped lines" })
map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump - back" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump - forward" })

map("n", "<leader>o", "o<esc>o", { desc = "Insert new lines" })
map("n", "<leader>O", "O<esc>O", { desc = "Insert new lines" })

-- Text search
map("n", "n", "nzz", { desc = "Next search match" })
map("n", "*", "*zz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
map("n", "#", "#zz", { desc = "Previous search match" })

map("n", "Y", "yy", { desc = "Yank line" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })

map("n", "<leader>/", function()
  vim.fn.feedkeys("/\\<\\>")
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<Left>\\<Left>"'))
end, { desc = "Find - exact match" })

map("v", "<leader>/", function()
  local text = get_visual_selection()
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
map("v", "<leader>d", '"_d', { desc = "Delete contents to black hole register" })

map("i", "<c-t>", function()
  vim.fn.feedkeys("TODO: ")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<esc>"'), "n", true)
  vim.fn.feedkeys("gccA")
end, { desc = "Insert - [T]ODO comment" })

map("n", "<leader>gr", function()
  vim.fn.feedkeys(":%s/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/g")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<left>\\<left>"'), "n", true)
end, { desc = "[R]eplace in file - word under cursor" })

map("v", "<leader>gr", function()
  vim.fn.feedkeys(":s/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/g")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<left>\\<left>"'), "n", true)
end, { desc = "[R]eplace in file - word under cursor" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "[B]uffer - delete [A]ll" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "[B]uffer - delete [O]thers" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "[B]uffer - next" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "[B]uffer - previous" })
map({ "n", "i" }, "<C-s>", "<cmd>w<cr>", { desc = "[B]uffer - save" })

-- Tabs
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
map("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "[T]ab [Q]uit" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "[T]ab - delete [O]thers" })
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "[T]ab - next" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "[T]ab - previous" })

-- Quickfix list
local function goto_qf_item(opts)
  opts = opts or {}
  local prev = opts.prev or false

  if prev then
    local ok, _ = pcall(vim.cmd, "cprevious")
    if not ok then
      vim.cmd("cfirst")
      notify("No previous qf items")
    end

  else
    local ok, _ = pcall(vim.cmd, "cnext")
    if not ok then
      vim.cmd("clast")
      notify("No more qf items")
    end
  end

  vim.fn.feedkeys("zz")
end

map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "[Q]uickfix [L]ist - show" })
map("n", "]q", goto_qf_item, { desc = "[Q]uickfix List - next" })
map("n", "[q", function()
  goto_qf_item({ prev = true })
end, { desc = "[Q]uickfix List - previous" })
map("n", "<leader>qq", "<cmd>cclose<cr>", { desc = "[Q]uickfix List - [Q]uit" })

-- TODO: find based on treesitter export node
-- map("n", "<leader>R", function()
-- vim.api.nvim_feedkeys("gg/export\nWW", "n", true)
-- vim.fn.feedkeys("<leader>r")
-- end, { desc = "Lsp - [G]o to file [R]eferences" })

map("n", "<leader>ml", function()
  vim.cmd([[vnew]])
  vim.cmd([[:put =execute('messages')]])
end, { desc = "[M]essage [L]ist" })

map("n", "<leader>sc", function()
  if not vim.o.hlsearch then
    vim.o.hlsearch = true
  else
    vim.o.hlsearch = false
  end
end, { desc = "Toggle [S]earch [C]ount and hlsearch" })

map("n", "+", function()
  vim.cmd([[vertical resize +2]])
end, { desc = "Window resize - increase horizontal" })

map("n", "_", function()
  vim.cmd([[vertical resize -2]])
end, { desc = "Window resize - increase horizontal" })

map("n", "gof", function()
  vim.cmd([[only]])
  vim.cmd([[vs]])
  vim.fn.feedkeys("gf")
end, { desc = "[G]o to [F]ile in vertical split" })

map("n", "<leader>hl", function()
  local hl = vim.treesitter.get_captures_at_cursor(0)
  vim.print(hl)
end, { desc = "[H]igh[L]ight group under curor" })

-- add word under cursor to search without moving
map("n", "<leader>*", function()
  local fn = vim.fn
  fn.setreg("/", [[\V\<]] .. fn.escape(fn.expand("<cword>"), [[/\]]) .. [[\>]])
  fn.histadd("/", fn.getreg("/"))
  vim.o.hlsearch = true
end, { desc = "[H]igh[L]ight group under curor" })
