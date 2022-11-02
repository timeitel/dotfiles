local neogit = require("neogit")

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
