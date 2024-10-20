local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-;>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      autochdir = true,
    })

    local map = require("tmtl.utils").map

    map("n", "<leader>rw", function()
      vim.cmd([[ TermExec cmd="docker compose up --watch" name="Docker Watcher" ]])
    end, { desc = "[R]un [W]atcher" })
  end,
}

return M
