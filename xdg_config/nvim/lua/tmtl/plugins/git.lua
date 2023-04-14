local M = {
  "bobrown101/git-blame.nvim",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "TimUntersberger/neogit",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        disable_insert_on_commit = false,
        integrations = {
          diffview = true,
        },
        mappings = {
          status = {
            ["d"] = function() -- open diff anywhere in status window and in an actual diffview tab, not a neogit wrapper
              vim.cmd([[ DiffviewOpen ]])
            end,
          },
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  },
}

return M
