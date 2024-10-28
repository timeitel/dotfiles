local M = {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<leader>rw",
      "<CMD>TermExec cmd='docker compose up --watch' name='Docker Watcher'<CR>",
      desc = "[R]un [W]atcher",
    },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-;>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      autochdir = true,
    })
  end,
}

return M
