local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function()
    require("typescript-tools").setup {
      on_attach = function(_, bufnr)
        local lsp_maps = require("tmtl.keymaps-lsp")
        lsp_maps.attach(bufnr)
      end,
    }
  end,
}

return M
