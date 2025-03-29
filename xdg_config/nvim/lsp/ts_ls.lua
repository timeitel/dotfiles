return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false -- done by prettierd
  end,
  handlers = {
    ["textDocument/definition"] = function(_, result, params)
      local util = require("vim.lsp.util")
      if result == nil or vim.tbl_isempty(result) then
        local _ = vim.lsp.log.info() and vim.lsp.log.info(params.method, "No location found")
        return nil
      end

      if vim.islist(result) then
        util.show_document(result[1], "utf-8", { focus = true })
      else
        util.show_document(result, "utf-8", { focus = true })
      end
    end,
  },
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
  },
  commands = {
    OrganizeImports = {
      function()
        local c = vim.lsp.get_clients({ name = "ts_ls", bufnr = 0 })
        c[1]:exec_cmd({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        })
      end,
      description = "Organize Imports",
    },
  },
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
}
