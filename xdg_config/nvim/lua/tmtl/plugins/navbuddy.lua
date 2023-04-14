local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local navbuddy = require("nvim-navbuddy")
    local actions = require("nvim-navbuddy.actions")

    navbuddy.setup({
      window = {
        border = "rounded",
        size = "50%",
        position = "100%",
        sections = {
          left = {
            size = "30%",
          },
          mid = {
            size = "40%",
          },
          right = {},
        },
      },
      mappings = {
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<C-q>"] = actions.close,

        ["j"] = actions.next_sibling,
        ["k"] = actions.previous_sibling,

        ["h"] = actions.parent,
        ["l"] = actions.children,

        ["v"] = actions.visual_name,
        ["V"] = actions.visual_scope,

        ["y"] = actions.yank_name,
        ["Y"] = actions.yank_scope,

        ["i"] = actions.insert_name,
        ["I"] = actions.insert_scope,

        ["a"] = actions.append_name,
        ["A"] = actions.append_scope,

        ["r"] = actions.rename,

        ["d"] = actions.delete,

        ["f"] = actions.fold_create,
        ["F"] = actions.fold_delete,

        ["c"] = actions.comment,

        ["<enter>"] = actions.select,
        ["o"] = actions.select,
      },
      lsp = {
        auto_attach = true,
      },
    })
  end,
}

return M
