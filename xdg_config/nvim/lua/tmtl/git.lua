local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "NeogitCommitComplete",
  group = group,
  callback = function()
    vim.defer_fn(function()
      vim.cmd([[DiffviewClose]])
    end, 150)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NeogitPopup", "NeogitCommitMessage" },
  group = group,
  callback = function()
    vim.cmd([[wincmd J]])
  end,
})

-- TODO: on diffview close, reattach tab mapping
