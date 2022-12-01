local neogit = require("neogit")
-- TODO: override d in status window for leadergd to open diffview
neogit.setup({
  disable_commit_confirmation = true,
  disable_insert_on_commit = false,
  integrations = {
    diffview = true,
  },
  mappings = {
    status = {
      ["<C-h>"] = neogit.close,
    },
  },
})
