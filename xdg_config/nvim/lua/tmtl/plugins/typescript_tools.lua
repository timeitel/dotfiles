-- TODO: try again when more developed
-- local M = {
--   "pmizio/typescript-tools.nvim",
--   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
--   opts = {},
--   config = function()
--     require("typescript-tools").setup {
--       on_attach = function(_, bufnr)
--         local lsp_maps = require("tmtl.keymaps-lsp")
--         lsp_maps.attach(bufnr)
--       end,
--       -- settings = {
--       --   tsserver_file_preferences = {
--       --     includeInlayParameterNameHints = "all",
--       --     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--       --     includeInlayFunctionParameterTypeHints = true,
--       --     includeInlayVariableTypeHints = true,
--       --     includeInlayVariableTypeHintsWhenTypeMatchesName = true,
--       --     includeInlayPropertyDeclarationTypeHints = true,
--       --     includeInlayFunctionLikeReturnTypeHints = true,
--       --     includeInlayEnumMemberValueHints = true,
--       --   },
--       -- },
--     }
--   end,
-- }

return {}
