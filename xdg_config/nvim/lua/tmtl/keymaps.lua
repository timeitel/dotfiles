local utils = require("tmtl.utils")
local map = utils.map
local notify = require("notify")

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("n", "'", "`", { desc = "Jump to mark - always go to column instead of just first non-blank" })

map("v", ">", ">gv", { desc = "Re-highlight visual selection after bumping indent" })
map("v", "<", "<gv", { desc = "Re-highlight visual selection after bumping indent" })

map("n", "X", "xi", { desc = "Replacement for vanilla 's'" })

map("v", "p", "P", { desc = "Keep register on visual paste" })
map("v", "P", "p", { desc = "Replace register on visual paste" })

map("n", "'i", "'.", { desc = "Jump to line of last edit - alias" })

map({ "n", "v" }, "q", function()
  if vim.b.overseer_task ~= nil or vim.api.nvim_win_get_config(0).relative ~= '' then
    return "<cmd>close<cr>"
  else
    return "<esc>"
  end
end, { desc = "Return to normal mode", expr = true })
map("s", "<C-q>", "<Esc>", { desc = "Return to normal mode" })
map("n", "Q", "q", { desc = "Safer trigger for macro recording" })

--- operator aliases

Last_Motion = ''
local opts = { desc = "Operator mode syntax aliases", expr = true }
local function set_motion_and_feed(str)
  return function()
    Last_Motion = str
    return str
  end
end

map({ "o", "x" }, "<C-q>", "<Esc>", { desc = "Exit operator mode" })
map({ "o", "x" }, "aW", set_motion_and_feed('aW'), opts) -- [q]uote
map({ "o", "x" }, "iW", set_motion_and_feed('iW'), opts) -- [q]uote
map({ "o", "x" }, "aw", set_motion_and_feed('aw'), opts) -- [q]uote
map({ "o", "x" }, "iw", set_motion_and_feed('iw'), opts) -- [q]uote
map({ "o", "x" }, "iq", set_motion_and_feed('i"'), opts) -- [q]uote
map({ "o", "x" }, "aq", set_motion_and_feed('a"'), opts)
map({ "o", "x" }, "is", set_motion_and_feed("i'"), opts) -- [s]ingle quote
map({ "o", "x" }, "as", set_motion_and_feed("a'"), opts)
map({ "o", "x" }, "il", set_motion_and_feed("i`"), opts) -- template [l]iteral string
map({ "o", "x" }, "al", set_motion_and_feed("a`"), opts)
map({ "o", "x" }, "ir", set_motion_and_feed("i["), opts) -- [r]ectangular brackets
map({ "o", "x" }, "ar", set_motion_and_feed("a["), opts)
map({ "o", "x" }, "ic", set_motion_and_feed("i{"), opts) -- [c]urly brackets
map({ "o", "x" }, "ac", set_motion_and_feed("a{"), opts)
map("n", "ga", function() return "v" .. Last_Motion .. "P" end, { desc = "Replace with last motion", expr = true }) -- all wrapping is done for this shortcut map

--- / operator aliases

map("c", "<C-q>", function() vim.api.nvim_input("<Esc>") end, { desc = "Return to normal mode" })

map("i", "kj", "<Esc>", { desc = "Return to normal mode" })
map("t", "kj", "<C-\\><C-n>", { desc = "Return to normal mode" })
map("i", "<Tab>", "<Right>", { desc = "Cursor right" })
map("i", "<C-f>", "<Right>", { desc = "Cursor right" })
map("i", "<C-b>", "<Left>", { desc = "Cursor left" })
map("i", "<C-d>", "<Esc>lcw", { desc = "Delete word right" })

map({ "n", "v" }, "j", "gj", { desc = "Down one line, including wrapped lines" })
map({ "n", "v" }, "k", "gk", { desc = "Up one line, including wrapped lines" })
map("n", "<C-b>", "<C-^>", { desc = "Jump - previous file" })
map("n", "<C-d>", "<C-d>zz", { desc = "Jump - down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump - up" })
map("n", "<C-i>", "<C-i>", { desc = "Re-map since mapping <Tab> loses <C-i>" })

map("n", "<leader>o", "o<esc>o", { desc = "Insert new lines" })
map("n", "<leader>O", "O<esc>O", { desc = "Insert new lines" })

-- Text search
map("n", "n", "nzz", { desc = "Next search match" })
map("n", "*", "*zz", { desc = "Next search match" })
map("n", "N", "Nzz", { desc = "Previous search match" })
map("n", "#", "#zz", { desc = "Previous search match" })

map("n", "<leader>cc", utils.change_case, { desc = "[C]hange [C]ase" })

map("n", "Y", "yy", { desc = "Yank line" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })

map("n", "<leader>/", function()
  vim.fn.feedkeys("/\\<\\>")
  vim.api.nvim_input("<Left><Left>")
end, { desc = "Find - exact match" })

map("v", "<leader>/", function()
  local text = utils.get_visual_selection()
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

map("i", "<c-t>", "iTODO: <esc>gccA", { desc = "Insert - [T]ODO comment", remap = true })

map("n", "<leader>gr", function()
  vim.fn.feedkeys(":%s/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<c-r>\\<c-w>"'), "n", true)
  vim.fn.feedkeys("/g")
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<left>\\<left>"'), "n", true)
end, { desc = "[R]eplace in file - word under cursor" })

map("v", "<leader>gr", function()
  vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<Esc>"'), "n", true)
  local cword = vim.fn.expand("<cword>")
  vim.fn.feedkeys("gv")
  vim.fn.feedkeys(":s/" .. cword .. "/" .. cword .. "/g")
  vim.api.nvim_input("<left><left>")
end, { desc = "[R]eplace in selection - word under cursor" })

-- Buffers
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "[B]uffer delete [A]ll" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "[B]uffer [N]ew" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "[B]uffer delete [O]thers" })
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
map("n", "[q", function() goto_qf_item({ prev = true }) end, { desc = "[Q]uickfix List - previous" })
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

map("n", "+", "<cmd>vertical resize +2<cr>", { desc = "Window resize - increase horizontal" })

map("n", "_", "<cmd>vertical resize -2<cr>", { desc = "Window resize - increase horizontal" })

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

map("n", "<C-a>", function()
  local word = vim.fn.expand('<cword>')

  if word == "false" then
    return "ciwtrue<esc>"
  elseif word == "true" then
    return "ciwfalse<esc>"
  else
    return "<C-a>"
  end
end, { desc = "Improved increment", expr = true })
