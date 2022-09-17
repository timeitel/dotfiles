local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

vim.g.mapleader = " "

-- TODO: fix for all modes
map("", "H", "^")
map("", "L", "$")
map("", "<C-q>", "<ESC>")
map("c", "<C-q>", "<ESC>")

map("i", "kj", "<ESC>")
-- map("i", "<C-j>", "<ESC>") -- TODO: nvim cmp suggestions */
-- map("i", "<C-j>", "<ESC>")

map("v", "*", 'y/<C-R>"<CR>') -- search for current selection
map("v", "#", 'y?<C-R>"<CR>') -- search for current selection
map("v", "p", "pgvy")
map("v", "P", "Pgvy")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "Y", "yy")

map("n", "<leader>sv", ":luafile $MYVIMRC<cr>") -- source vimrc
map("n", "<leader>sp", ":PackerSync<cr>") -- source / synce plugins

-- LSP
map("n", "J", ":lua vim.lsp.buf.references()<cr>")
map("n", "K", ":lua vim.lsp.buf.hover()<cr>")
map("n", "<C-,>", ":lua vim.lsp.buf.code_action()<cr>")

-- Telescope
map("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fc", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
map("n", "<leader>fg", ":lua require('telescope.builtin').git_status()<cr>")
map("n", "<leader>ff", ":lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fh", ":lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>fb", ":Telescope file_browser<cr>")
map("n", "<leader>en", ":lua require('telescope.builtin').find_files() cwd=~/.config/nvim<cr>") -- edit neovim

-- Harpoon
map("n", "<leader>a", ":lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>l", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<A-n>", ":lua require('harpoon.ui').nav_next()<cr>")
map("n", "<A-p>", ":lua require('harpoon.ui').nav_previous()<cr>")
map("n", "<A-h>", ":lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<A-j>", ":lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<A-k>", ":lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<A-l>", ":lua require('harpoon.ui').nav_file(4)<cr>")
