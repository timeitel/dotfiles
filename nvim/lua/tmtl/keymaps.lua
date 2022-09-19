local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true, noremap = true, })
end

local function reload_nvim()
    for k, v in pairs(package.loaded) do
        if string.match(k, "^tmtl") then
            package.loaded[k] = nil
        end
    end
    vim.cmd("source ~/.config/nvim/init.lua")
    print("Reloaded nvim config")
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

map("n", "<leader>sp", ":PackerSync<cr>") -- source / synce plugins
map("n", "<F5>", reload_nvim)
map("n", "<leader>i", "i <ESC>i")

-- LSP
map("n", "K", vim.lsp.buf.hover)
map("n", "J", "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
map("n", "gd", vim.lsp.buf.definition)
map("n", "gt", vim.lsp.buf.type_definition)
map("n", "gi", vim.lsp.buf.implementation)

map("n", "<leader>dj", vim.diagnostic.goto_next)
map("n", "<leader>dk", vim.diagnostic.goto_prev)
map("n", "<leader>da", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map("n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<cr>")
map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>") -- TODO: fix telescope not respecting nvim lsp config 
-- map("n", "<leader>dc", "<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<cr>") -- buffer clients

-- Fuzzy finder (files)
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope').extensions.file_browser.file_browser({ grouped = true })<cr>")
map("n", "<leader>fc", "<cmd>Telescope find_files cwd=~/.dotfiles<cr>") -- edit neovim

-- Fuzzy finder (git)
-- map("n", "<leader>gn", "git next diff")
-- map("n", "<leader>gp", "git previous diff")
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_commits()<cr>")

-- Quick edit files
map("n", "<leader>qa", "<cmd>lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>ql", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<A-n>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
map("n", "<A-p>", "<cmd>lua require('harpoon.ui').nav_previous()<cr>")
map("n", "<A-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<A-j>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<A-k>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<A-l>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
