local neogit = require("neogit")

neogit.setup({
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
