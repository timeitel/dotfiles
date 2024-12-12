vim.keymap.set("n", "S", "<CMD>silent Git add .<CR>", { desc = "[G]it [S]tage all", buffer = true })
vim.keymap.set("n", "U", "<CMD>silent Git restore --staged .<CR>", { desc = "[G]it [U]nstage all", buffer = true })
vim.keymap.set("n", "C", "<CMD>silent Git commit --quiet<CR>", { desc = "[G]it [C]ommit", buffer = true })
vim.keymap.set("n", "P", "<CMD>Git push<CR>", { desc = "[G]it [P]ush", buffer = true })
