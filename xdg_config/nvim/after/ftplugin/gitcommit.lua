vim.fn.feedkeys("i")

vim.keymap.set("n", "q", "<CMD>close<CR>", { desc = "Close status buffer", buffer = true })
