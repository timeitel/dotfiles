return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false -- done by prettierd

    vim.keymap.set("n", "<leader>li", function()
      local c = vim.lsp.get_clients({ name = "ts_ls", bufnr = 0 })
      c[1]:exec_cmd({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, { desc = "[L]SP organize [I]mports", buffer = 0 })
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
