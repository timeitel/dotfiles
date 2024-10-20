local M = {
  "mfussenegger/nvim-dap",
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lsp_maps = require("tmtl.keymaps-lsp")
      local rt = require("rust-tools")
      local rust_maps = require("tmtl.keymaps-rust")
      local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local dap = require("dap")

      dap.listeners.before["event_initialized"]["tmtl_handler"] = require("rust-tools").inlay_hints.disable
      dap.listeners.before["event_terminated"]["tmtl_handler"] = require("rust-tools").inlay_hints.enable

      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            lsp_maps.attach(bufnr)
            rust_maps.attach(bufnr)
          end,
          capabilities = capabilities,
        },
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp_maps = require("tmtl.keymaps-lsp")
      local lspconfig = require("lspconfig")

      require("lspconfig.ui.windows").default_options.border = "rounded"
      local protocol = require("vim.lsp.protocol")
      local tsHandlers = {
        ["textDocument/definition"] = function(_, result, params)
          local util = require("vim.lsp.util")
          if result == nil or vim.tbl_isempty(result) then
            local _ = vim.lsp.log.info() and vim.lsp.log.info(params.method, "No location found")
            return nil
          end

          if vim.islist(result) then
            util.jump_to_location(result[1], "utf-8", true)
          else
            util.jump_to_location(result, "utf-8", true)
          end
        end,
      }

      -- Set up completion using nvim_cmp with LSP source
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local html_caps = capabilities
      html_caps.textDocument.completion.completionItem.snippetSupport = true
      lspconfig.html.setup({
        on_attach = lsp_maps.attach,
        capabilities = html_caps,
        init_options = {
          provideFormatter = false,
        },
      })

      lspconfig.templ.setup({ on_attach = lsp_maps.attach })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "html", "javascript", "typescript", "typescriptreact", "react", "templ" },
      })

      lspconfig.gopls.setup({
        on_attach = lsp_maps.attach,
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
        on_attach = function(client, bufnr)
          lsp_maps.attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false -- done by prettierd
        end,
        handlers = tsHandlers,
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
              vim.lsp.buf.execute_command({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
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

      lspconfig.lua_ls.setup({
        on_attach = lsp_maps.attach,
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim", "hs", "require" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
        capabilities = capabilities,
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
        float = {
          source = true,
          border = "rounded",
          header = "",
        },
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      })

      protocol.CompletionItemKind = {
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
