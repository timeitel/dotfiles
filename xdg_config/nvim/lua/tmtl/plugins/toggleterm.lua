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

    vim.keymap.set("n", "<leader>;v", function()
      vim.cmd([[ ToggleTerm size=70 direction=vertical ]])
    end, { desc = "New vertical terminal" })
  end,
}

return M
