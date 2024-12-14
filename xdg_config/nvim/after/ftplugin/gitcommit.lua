vim.fn.feedkeys("i")

vim.keymap.set("n", "q", "<CMD>close!<CR>", { desc = "Close status buffer", buffer = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  buffer = 0,
  callback = function()
    vim.schedule(function()
      vim.cmd("DiffviewClose")
    end)
  end,
})
