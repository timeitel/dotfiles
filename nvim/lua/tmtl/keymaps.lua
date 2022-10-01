-- TODO: file modified status in search buffers and also close buffers
local function map(m, k, v, opts)
    opts = opts or {}
    opts.silent = true
    opts.noremap = true
    vim.keymap.set(m, k, v, opts)
end

function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ""
    end
end

vim.g.mapleader = " "

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

map("i", "kj", "<ESC>")

map("v", "*", 'y/<C-R>"<CR>', { desc = "Search for current selection" })
map("v", "#", 'y?<C-R>"<CR>', { desc = "Search for current selection" })
map("v", "p", "pgvy")
map("v", "P", "Pgvy")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "Y", "yy")

-- from clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

map("n", "<leader>sp", ":PackerSync<cr>", { desc = "Sync plugins" })
-- map("n", "<F5>", reload_nvim, { desc = "Reload config" })
map("n", "<leader>i", "i <ESC>i")
map("n", "<leader>?", "<cmd>WhichKey<cr>")

-- Tabs (buffers)
map("n", "<leader>tc", "<cmd>:bd<cr>")
map("n", "<leader>ta", "<cmd>:%bd<cr>")
map("n", "<leader>to", "<cmd>%bd|e#|bd#<cr>")
map("n", "<leader>tj", "<cmd>:bNext<cr>")
map("n", "<leader>tk", "<cmd>:bprevious<cr>")

-- Diagnostics -- only assign if language server attached to buffer / window -> so C-j can work in other contexts
map("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>zz<cmd>CodeActionMenu<cr>") -- TODO: get cursor position, spawn menu at location then check if any results, float if no actions
map("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>zz<cmd>CodeActionMenu<cr>")
map("n", "<leader>dj", "<cmd>vim.diagnostic.goto_next()<cr>")
map("n", "<leader>dk", "<cmd>vim.diagnostic.goto_prev()<cr>")
map("n", "<leader>da", "<cmd>CodeActionMenu<cr>")
map("n", "<leader>dh", "<cmd>lua vim.diagnostic.open_float()<cr>")
map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>")
map(
    "n",
    "<leader>do",
    "<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<cr>"
)
map("n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<cr>")

-- Fuzzy finder (files)
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map(
    "n",
    "<leader>/",
    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
    { desc = "Find in current buffer" }
)
map("v", "<leader>/", function()
    local text = vim.getVisualSelection()
    require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
end, { desc = "Find in current buffer" })

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("v", "<leader>ff", function()
    local text = vim.getVisualSelection()
    require("telescope.builtin").live_grep({ default_text = text })
end)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fc", "<cmd>Telescope find_files cwd=~/.dotfiles<cr>")
map(
    "n",
    "<leader>fw",
    "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h')})<cr>",
    { desc = "Find in cwd" }
)
map("n", "<leader>fx", ":Telescope find_files cwd=~/") -- x for explore??
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>")
map("n", "<leader>fm", "<cmd>Telescope harpoon marks<cr>", { desc = "Find in makrs" })

-- Fuzzy finder (browser)
map(
    "n",
    "<leader>bp",
    "<cmd>lua require('telescope').extensions.file_browser.file_browser({ grouped = true })<cr>",
    { desc = "Browse project" }
)
map(
    "n",
    "<leader>bw",
    "<cmd>lua require('telescope').extensions.file_browser.file_browser({ grouped = true,  cwd = vim.fn.expand('%:p:h') })<cr>"
    ,
    { desc = "Browse cwd" }
)
map(
    "n",
    "<leader>bc",
    "<cmd>lua require('telescope').extensions.file_browser.file_browser({ grouped = true,  cwd = '~/.dotfiles' })<cr>",
    { desc = "Browse config" }
)
map("n", "<leader>bx", "<cmd>Telescope file_browser grouped=true cwd=~/code<cr>", { desc = "Browse projects" })

-- Git
map("n", "<leader>gs", "<cmd>Neogit<cr>")
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>gc", "<cmd>Neogit commit<cr>")
map("n", "<leader>gx", "<cmd>Gitsigns reset_buffer<cr><cmd>DiffviewRefresh<cr>")
map("n", "<leader>gfs", "<cmd>Gitsigns stage_buffer<cr><cmd>DiffviewRefresh<cr>")
map("n", "<leader>gb", "<cmd>:lua require('git_blame').run()<cr>")

map("n", "<leader>hj", "<cmd>Gitsigns next_hunk<cr>zz")
map("n", "<leader>hk", "<cmd>Gitsigns prev_hunk<cr>zz")
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>")
map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr><ESC><cmd>DiffviewRefresh<cr>")
map("n", "<leader>hx", "<cmd>Gitsigns reset_hunk<cr><cmd>DiffviewRefresh<cr>")
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr><cmd>DiffviewRefresh<cr>")

-- Quick fix list
map("n", "<leader>ql", "<cmd>copen<cr>")
map("n", "<leader>qj", "<cmd>cnext<cr>")
map("n", "<leader>qk", "<cmd>cprevious<cr>")
-- map("n", "<leader>qa", "<cmd>cprevious<cr>") --TODO: add to qf list

-- Quick edit files
map("n", "<leader>ea", "<cmd>lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>el", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<A-n>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
map("n", "<A-p>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
map("n", "<A-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<A-j>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<A-k>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<A-l>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[nmap <Leader>(( <Plug>ReplaceWithRegisterLine]]) -- TODO: just unmap
vim.g.code_action_menu_show_details = false -- TODO: move
vim.g.camelcasemotion_key = "<leader>"
