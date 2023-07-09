local M = {
  "rcarriga/nvim-notify",
  version = "*",
  config = function()
    vim.notify = function(msg, level, opts)
      return require('notify')(msg, level, opts)
    end

    require('notify').setup({
      timeout = 1000
    })
  end,
  event = "VeryLazy",
}

return M
