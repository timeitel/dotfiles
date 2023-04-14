local M = {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } },
  "bobrown101/git-blame.nvim",
}

return M
