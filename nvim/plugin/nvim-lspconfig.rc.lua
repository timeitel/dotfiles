local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local protocol = require("vim.lsp.protocol")
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local tsHandlers = {
  ["textDocument/definition"] = function(_, result, params)
    local util = require("vim.lsp.util")
    if result == nil or vim.tbl_isempty(result) then
      local _ = vim.lsp.log.info() and vim.lsp.log.info(params.method, "No location found")
      return nil
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], "utf-8", true)

      --if #result > 1 then
      --    local isReactDTs = false
      --    ---@diagnostic disable-next-line: unused-local
      --    for key, value in pairs(result) do
      --        print(key, value)
      --        if string.match(value.uri, "react/index.d.ts") then
      --            isReactDTs = true
      --            break
      --        end
      --    end
      --    if not isReactDTs then
      --        -- this sets the value for the quickfix list
      --        util.set_qflist(util.locations_to_items(result, "utf-8"))
      --        -- this opens the quickfix window
      --        vim.api.nvim_command("copen")
      --        vim.api.nvim_command("wincmd p")
      --    end
      --end
    else
      util.jump_to_location(result, "utf-8", true)
    end
  end,
}

local on_attach = function(_, bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr, desc = d })
  end

  -- TODO: format the range after accepting code action
  -- Diagnostics
  buf_map("n", "<C-j>", function()
    vim.diagnostic.goto_next({ float = false })
    vim.fn.feedkeys("zz") -- TODO: only center if there's diagnostics and check if no code actions, then pop dh
    vim.lsp.buf.code_action()
  end, "Next error and pop code action / hover")

  buf_map("n", "<C-k>", function()
    vim.diagnostic.goto_prev({ float = false })
    vim.fn.feedkeys("zz")
    vim.lsp.buf.code_action()
  end, "Previous error and pop code action / hover")

  buf_map("n", "<leader>dj", function()
    vim.diagnostic.goto_next({ float = { border = border } })
    vim.fn.feedkeys("zz")
  end, "Next error")

  buf_map("n", "<leader>dk", function()
    vim.diagnostic.goto_prev({ float = { border = border } })
    vim.fn.feedkeys("zz")
  end, "Previous error")

  buf_map("n", "<leader>da", function()
    vim.lsp.buf.code_action()
  end, "Code actions")

  buf_map("n", "<leader>dh", function()
    vim.diagnostic.open_float(0, { border = border })
  end, "Hover diagnostics")

  buf_map("n", "<leader>dl", function()
    vim.cmd("Telescope diagnostics")
  end, "List diagnostics")

  -- LSP
  buf_map("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, "Lsp - rename")

  buf_map("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
  end, "Lsp - signature")

  buf_map("n", "<leader>li", function()
    vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
  end, "Lsp - organize imports")

  buf_map({ "i", "n" }, "<C-S-Space>", function()
    vim.lsp.buf.signature_help()
  end, "Lsp - signature")

  buf_map("n", "gd", function()
    vim.cmd("Telescope lsp_definitions")
    vim.fn.feedkeys("zz")
  end)

  buf_map("n", "gD", function()
    vim.lsp.buf.declaration()
    vim.fn.feedkeys("zz")
  end)

  buf_map("n", "K", function()
    vim.lsp.buf.hover()
  end, "Hover")

  buf_map("n", "gr", function()
    require("telescope.builtin").lsp_references({ show_line = false, include_declaration = false })
  end)

  buf_map("n", "gt", function()
    vim.lsp.buf.type_definition()
    vim.fn.feedkeys("zz")
  end)

  buf_map("n", "gI", function()
    vim.lsp.buf.implementation()
    vim.fn.feedkeys("zz")
  end)
end

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

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false -- done by prettierd
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
      vim.fn.feedkeys("zz")
    end, { noremap = true, silent = true, buffer = bufnr })
  end,
  handlers = tsHandlers,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
  },
  capabilities = capabilities,
})

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" },
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
  on_attach = function(client, buffnr)
    on_attach(client, buffnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ buffer = buffnr, group = augroup_format })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = buffnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
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

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
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
