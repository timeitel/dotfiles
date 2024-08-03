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
      vim.cmd([[ TermExec cmd="docker compose -f compose.dev.yml up --watch" name="Docker Watcher" ]])
    end, { desc = "[R]un [W]atcher" })

    map("n", "<leader>gp", function()
      vim.cmd([[ 10TermExec cmd="git push" name="Git Push" ]])
    end, { desc = "[G]it [P]ush" })
  end,
}

return M
