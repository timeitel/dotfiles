local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NeogitPopup", "NeogitCommitMessage" },
  group = group,
  callback = function()
    vim.cmd.wincmd("J")
  end,
})

-- TODO: on diffview close, reattach tab mapping
