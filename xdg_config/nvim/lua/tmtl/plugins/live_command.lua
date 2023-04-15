local M = {
  "smjonas/live-command.nvim",
  config = function()
    local map = require("tmtl.utils").map
    map("v", "<leader>n", function()
      vim.fn.feedkeys(":Norm ")
    end, { desc = "[N]orm - execute normal mode on every line" })

    require("live-command").setup({
      commands = {
        Norm = { cmd = "norm" },
      },
    })
  end,
}

return M
