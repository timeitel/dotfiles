local M = {
  "neovim/nvim-lspconfig",
  config = function()
    local lsp_maps = require("tmtl.keymaps-lsp")
    local nvim_lsp = require("lspconfig")

    local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    require("lspconfig.ui.windows").default_options.border = border
    local protocol = require("vim.lsp.protocol")
    local tsHandlers = {
      ["textDocument/definition"] = function(_, result, params)
        local util = require("vim.lsp.util")
        if result == nil or vim.tbl_isempty(result) then
          local _ = vim.lsp.log.info() and vim.lsp.log.info(params.method, "No location found")
          return nil
        end

        if vim.tbl_islist(result) then
          util.jump_to_location(result[1], "utf-8", true)
        else
          util.jump_to_location(result, "utf-8", true)
        end
      end,
    }

    -- Set up completion using nvim_cmp with LSP source
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    nvim_lsp.eslint.setup({})
    nvim_lsp.gopls.setup({
      on_attach = function(_, bufnr)
        lsp_maps.attach(bufnr)
      end,
    })

    nvim_lsp.tsserver.setup({
      on_attach = function(client, bufnr)
        lsp_maps.attach(bufnr)
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
    })

    nvim_lsp.lua_ls.setup({
      on_attach = function(_, bufnr)
        lsp_maps.attach(bufnr)
      end,
      settings = {
        Lua = {
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

    nvim_lsp.rust_analyzer.setup({
      on_attach = function(_, buffnr)
        lsp_maps.attach(buffnr)
      end,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
      capabilities = capabilities,
    })

    local diagnostic_column_signs = { Error = "❌", Warn = "⚠️ ", Hint = "💡", Info = "ℹ️ " }
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
        source = "always", -- Or "if_many"
      },
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = border,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = border,
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
}

return M
