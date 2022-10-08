local opts = { silent = false, noremap = true, buffer = true }

vim.keymap.set("n", "<C-h>", "<cmd>lua require('code_action_menu').close_code_action_menu()<cr>", opts)
vim.keymap.set("n", "<C-l>", "<cmd>lua require('code_action_menu').execute_selected_action()<CR>", opts) --TODO: format after code action
