local map = require("tmtl.utils").map

require("live-command").setup({
  commands = {
    Norm = { cmd = "norm" },
  },
})

map("v", "<leader>n", function()
  vim.fn.feedkeys(":Norm ")
end, { desc = "[N]orm - execute normal mode on every line" })
