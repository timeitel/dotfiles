local M = {
  "rcarriga/nvim-notify",
  version = "*",
  config = function()
    vim.notify = function(msg, level, opts)
      -- https://github.com/neovim/nvim-lspconfig/issues/1931
      for _, banned in ipairs({ "No information available" }) do
        if msg == banned then
          return
        end
      end
      return require("notify")(msg, level, opts)
    end

    require("notify").setup({
      timeout = 400,
      stages = "fade",
    })
  end,
  event = "VeryLazy",
}

return M
