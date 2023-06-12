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

    map("n", "<leader>rt", function()
      -- TODO: add test script for cargo projects
      require('toggleterm').exec("npm run type-check")
    end, { desc = "[R]un [T]est" })

    map("n", "<leader>ra", function()
      -- TODO: add run script default for npm projects
      require('toggleterm').exec("cargo run")
    end, { desc = "[R]un [A]pp" })

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
