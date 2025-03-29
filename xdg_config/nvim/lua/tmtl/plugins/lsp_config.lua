local M = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach_lsp = require("tmtl.utils").on_attach_lsp
      local lspconfig = require("lspconfig")
      require("lspconfig.ui.windows").default_options.border = "rounded"
      -- Set up completion using nvim_cmp with LSP source
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "html", "javascript", "typescript", "typescriptreact", "react", "templ" },
      })

      lspconfig.gopls.setup({
        on_attach = on_attach_lsp,
        settings = {
          gopls = {
            ["ui.inlayhint.hints"] = {
              compositeLiteralFields = true,
              constantValues = true,
              parameterNames = true,
            },
          },
        },
      })

      lspconfig.ts_ls.setup({
        on_attach = function(client)
          on_attach_lsp()
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
        capabilities = capabilities,
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
      })

      local diagnostic_column_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(diagnostic_column_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        update_in_insert = true,
      })

      vim.lsp.protocol.CompletionItemKind = {
        "", -- Text
        "", -- Method
        "", -- Function
        "", -- Constructor
        "", -- Field
        "", -- Variable
        "", -- Class
        "ﰮ", -- Interface
        "", -- Module
        "", -- Property
        "", -- Unit
        "", -- Value
        "", -- Enum
        "", -- Keyword
        "﬌", -- Snippet
        "", -- Color
        "", -- File
        "", -- Reference
        "", -- Folder
        "", -- EnumMember
        "", -- Constant
        "", -- Struct
        "", -- Event
        "ﬦ", -- Operator
        "", -- TypeParameter
      }
    end,
  },
}

return M
