local M = {
  "smjonas/live-command.nvim",
  keys = {
    {
      "<leader>n",
      function()
        vim.fn.feedkeys(":Norm ")
      end,
      desc = "[N]orm - execute normal mode on every line",
      mode = "v",
    },
  },
  config = function()
    require("live-command").setup({
      commands = {
        Norm = { cmd = "norm" },
      },
    })
  end,
}

return M
