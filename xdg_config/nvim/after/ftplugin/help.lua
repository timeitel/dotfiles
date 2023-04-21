vim.schedule(function()
  vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
end)
vim.cmd([[wincmd L]])
