local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")
    local map = require("tmtl.utils").map

    -- prefix terminal number befor toggle open for multiple terminals
    toggleterm.setup({
      open_mapping = [[<C-;>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      autochdir = true,
    })

    local group = vim.api.nvim_create_augroup("ToggleTermGroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "UnceptionEditRequestReceived",
      callback = function()
        toggleterm.toggle()
      end,
      group = group,
    })
  end,
}

return M
