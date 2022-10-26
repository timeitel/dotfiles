local map = Utils.map

vim.g.mapleader = " "
vim.g.camelcasemotion_key = "<leader>"

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

map("i", "kj", "<ESC>")
map("i", "<A-l>", "<Right>")
map("i", "<A-h>", "<Left>")

map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "Y", "yy")
map("n", "zx", "<cmd>update<cr>")
map("n", "<leader>i", "i <ESC>i")
map("n", "<leader>?", "<cmd>WhichKey<cr>")
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
-- map("n", "<F5>", reload_nvim, { desc = "Reload config" })

-- Tabs (buffers)
map("n", "<leader>ba", "<cmd>:%bd<cr>")
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>")

-- Quick fix list
map("n", "<leader>ql", "<cmd>copen<cr>")
map("n", "<leader>qj", "<cmd>cnext<cr>")
map("n", "<leader>qk", "<cmd>cprevious<cr>")

map("n", "<leader>gr", function()
    vim.fn.feedkeys([[gg/export]])
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys([[WWgr]])
end)

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[nmap <Leader>(( <Plug>ReplaceWithRegisterLine]]) -- TODO: just unmap
