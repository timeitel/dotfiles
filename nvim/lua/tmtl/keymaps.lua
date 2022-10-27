local map = Utils.map

vim.g.mapleader = " "
vim.g.camelcasemotion_key = "<leader>"

map({ "n", "v", "o" }, "H", "^", { desc = "First character on line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character on line" })

map("i", "kj", "<ESC>", { desc = "Escape" })
map("i", "<A-l>", "<Right>", { desc = "Cursor right" })
map("i", "<A-h>", "<Left>", { desc = "Cursor left" })

map("n", "<C-b>", "<C-^>", { desc = "Previous file" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump back and center" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward and center" })
map("n", "n", "nzz", { desc = "Next search match and center" })
map("n", "N", "Nzz", { desc = "Previous search match and center" })
map("n", "Y", "yy", { desc = "Yank line" })
map("n", "zx", "<cmd>update<cr>", { desc = "Save buffer" })
map("n", "<leader>i", "i <ESC>i", { desc = "Enter insert mode with proceeding space" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

map("n", "<leader>sp", function()
    -- TODO
    -- local time = os.time(os.date("!*t"))
    if vim.fn.confirm("", "Are you sure you'd like to discard changes? (&Yes\n&No)", 1) == 1 then
        -- vim.cmd([[PackerSnapshot time]])
        -- vim.cmd([[PackerSync]])
    end
end, { desc = "Sync plugins" })

-- Tabs (buffers)
map("n", "<leader>ba", "<cmd>:%bd<cr>", { desc = "Delete all buffers" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete all other buffers" })

-- Quick fix list
map("n", "<leader>ql", "<cmd>copen<cr>", { desc = "Quickfix list - show" })
map("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "Quickfix list - next" })
map("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "Quickfix list - previous" })

map("n", "<leader>gr", function()
    vim.fn.feedkeys([[gg/export]])
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys([[WWgr]])
end, { desc = "Lsp - file references" })

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[xmap <Leader>r <Plug>ReplaceWithRegisterVisual]])
vim.cmd([[nmap <Leader>(( <Plug>ReplaceWithRegisterLine]]) -- TODO: just unmap
