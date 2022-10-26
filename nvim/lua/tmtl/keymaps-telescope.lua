local map = Utils.map
local getVisualSelection = Utils.getVisualSelection

-- Fuzzy finder (files)
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map(
    "n",
    "<leader>/",
    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
    { desc = "Find in current buffer" }
)
map("v", "<leader>/", function()
    local text = getVisualSelection()
    require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
end, { desc = "Find in current buffer" })

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("v", "<leader>ff", function()
    local text = getVisualSelection()
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
map("n", "<leader>fk", ":Telescope keymaps")
map("n", "<leader>fx", ":Telescope find_files cwd=~/")
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>")
map("n", "<leader><leader>fr", function()
    require("telescope.builtin").registers()
end)
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
