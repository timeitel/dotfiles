-- TODO: open two files at once into v split -> old files
-- TODO: kitty layouts
-- TODO: grep within current folder <leader>fF
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
map("i", "<A-l>", "<Right>")
map("i", "<A-h>", "<Left>")

map("v", "p", "pgvy")
map("v", "P", "Pgvy")

map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "Y", "yy")

-- from clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- TODO: create snapshot before syncing
map("n", "<leader>sp", ":PackerSync<cr>", { desc = "Sync plugins" })
-- map("n", "<F5>", reload_nvim, { desc = "Reload config" })
map("n", "<leader>i", "i <ESC>i")
map("n", "<leader>?", "<cmd>WhichKey<cr>")

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
map(
    "n",
    "<leader>fb",
    "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>"
)
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
-- map("n", "<leader>fy", "<cmd>Telescope frecency CWD", { desc = "Find frecent files" })

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

-- Tabs (buffers)
map("n", "<leader>ba", "<cmd>:%bd<cr>")
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>")

-- Git
-- map("n", "<leader>gr",) --TODO
map("n", "<leader>gs", "<cmd>Neogit<cr>")
map("n", "<leader><leader>gs", "<cmd>lua require('telescope.builtin').git_stash()<cr>")
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader><leader>gh", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>")
map("n", "<leader>gc", function()
    vim.cmd("DiffviewClose")
    vim.cmd("Neogit")
    vim.cmd("Neogit commit")
    vim.fn.feedkeys("c")
end)
map("n", "<leader>gfx", "<cmd>Gitsigns reset_buffer<cr>")
map("n", "<leader>gfs", "<cmd>Gitsigns stage_buffer<cr>")
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
map("n", "<leader><leader>gb", "<cmd>lua require('git_blame').run()<cr>")

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
-- map("n", "<leader>qa", "") --TODO: add to qf list

-- TODO: configure with c-h and c-l
-- Quick edit files
map("n", "<leader>ea", "<cmd>lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>el", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<leader>ej", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
map("n", "<leader>ek", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
map("n", "<A-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<A-j>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<A-k>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<A-l>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

map("n", "zx", "<cmd>update<cr>")

vim.cmd([[nmap <Leader>r <Plug>ReplaceWithRegisterOperator]])
vim.cmd([[nmap <Leader>(( <Plug>ReplaceWithRegisterLine]]) -- TODO: just unmap
vim.g.camelcasemotion_key = "<leader>"
