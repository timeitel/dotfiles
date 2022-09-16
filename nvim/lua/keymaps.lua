local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

vim.g.mapleader = " "

map("", "H", "^")
map("", "L", "$")

map("i", "kj", "<ESC>")
map("i", "<C-e>", "<C-x><C-e>")
map("i", "<C-y>", "<C-x><C-y>")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "K", "i<Enter><Esc>")
map("n", "Y", "yy")

map("n", "<leader>sv", ":luafile $MYVIMRC<cr>") -- source vimrc
map("n", "<leader>sp", ":PackerSync<cr>") -- source / synce plugins

-- LSP
map("n", "<leader>r", ":lua vim.lsp.buf.references()<cr>")
map("n", "<leader>h", ":lua vim.lsp.buf.hover()<cr>")
map("n", "<C-.>", ":lua vim.lsp.buf.code_action()<cr>")

-- Telescope
map("n", "<C-p>", ":lua require'telescope.builtin'.find_files()<cr>")
map("n", "<leader>fg", ":lua require'telescope.builtin'.git_status()<cr>")
map("n", "<leader>ff", ":lua require'telescope.builtin'.live_grep()<cr>")
map("n", "<leader>fb", ":Telescope file_browser<cr>")

-- Harpoon
map("n", "<leader>a", ":lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>l", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<A-n>", ":lua require('harpoon.ui').nav_next()<cr>")
map("n", "<A-p>", ":lua require('harpoon.ui').nav_previous()<cr>")
map("n", "<C-h>", ":lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<C-j>", ":lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<C-k>", ":lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<C-l>", ":lua require('harpoon.ui').nav_file(4)<cr>")
