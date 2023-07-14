local group = vim.api.nvim_create_augroup('MyCustomNeogitEvents', { clear = true })

vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitPushComplete',
  group = group,
  callback = require('neogit').close,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitCommitComplete',
  group = group,
  callback = function()
    vim.defer_fn(function()
      vim.cmd([[DiffviewClose]])
    end, 50)
  end
})
