local assign_to_next_prev = Utils.assign_to_next_prev
local ok, nvim_lsp = pcall(require, "lspconfig")
if not ok then
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
    else
      util.jump_to_location(result, "utf-8", true)
    end
  end,
}

-- TODO: sort out typing of globals
function Goto_Diagnostic(opts)
  opts = opts or {}
  local prev = opts.prev or false

  if prev then
    vim.diagnostic.goto_prev({ float = { border = border }, severity = opts.severity })
  else
    vim.diagnostic.goto_next({ float = { border = border }, severity = opts.severity })
  end

  vim.fn.feedkeys("zz")
end

local attach_lsp_maps = function(_, bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr, desc = d })
  end

  -- TODO: 1. <leader>dh if no code actions
  -- TODO: 2. floating diag window max width
  -- TODO: format the range after accepting code action
  -- Diagnostics
  buf_map("n", "<leader>dj", function()
    assign_to_next_prev(function()
      Goto_Diagnostic({ severity = vim.diagnostic.severity.ERROR })
    end, function()
      Goto_Diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
    end)

    Goto_Diagnostic({ severity = vim.diagnostic.severity.ERROR })
  end, "[D]iagnostics - next error")

  buf_map("n", "<leader><leader>dj", function()
    assign_to_next_prev(Goto_Diagnostic, function()
      Goto_Diagnostic({ prev = true })
    end)

    Goto_Diagnostic()
  end, "[D]iagnostics - next diagnostic")

  buf_map("n", "<leader>dk", function()
    assign_to_next_prev(function()
      Goto_Diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
    end, function()
      Goto_Diagnostic({ severity = vim.diagnostic.severity.ERROR })
    end)

    Goto_Diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
  end, "[D]iagnostics - previous error")

  buf_map("n", "<leader><leader>dk", function()
    assign_to_next_prev(function()
      Goto_Diagnostic({ prev = true })
    end, Goto_Diagnostic)

    Goto_Diagnostic({ prev = true })
  end, "[D]iagnostics - previous diagnostic")

  buf_map("n", "<leader>da", function()
    vim.lsp.buf.code_action()
  end, "[D]iagnostics - code [A]ctions")

  buf_map("n", "<leader>dh", function()
    vim.diagnostic.open_float(0, { border = border })
  end, "[D]iagnostics - [H]over")

  buf_map("n", "<leader>dl", function()
    vim.cmd("Telescope diagnostics")
  end, "[D]iagnostics [L]ist - show")

  -- LSP
  buf_map("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, "[L]sp - [R]ename")

  buf_map("n", "<leader><leader>lr", function()
    vim.cmd([[LspRestart]])
  end, "[L]sp - [R]ename")

  buf_map("n", "<leader>ls", function()
    vim.cmd([[LspStop]])
  end, "[L]sp - [S]ignature")

  buf_map("n", "<leader><leader>ls", function()
    vim.cmd([[LspStart]])
  end, "[L]sp - [S]ignature")

  buf_map("n", "<leader>li", function()
    vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
  end, "[L]sp - organize [I]mports")

  buf_map({ "i", "n" }, "<C-S-Space>", function()
    vim.lsp.buf.signature_help()
  end, "Lsp - signature")

  buf_map("n", "gd", function()
    require("telescope.builtin").lsp_definitions()

    vim.defer_fn(function()
      vim.fn.feedkeys("zz")
    end, 10)
  end, "Lsp - [G]o to [D]efinition")

  buf_map("n", "gD", function()
    vim.lsp.buf.declaration()
    vim.fn.feedkeys("zz")
  end, "Lsp - [G]o to [D]eclaration")

  buf_map("n", "K", function()
    vim.lsp.buf.hover()
  end, "Lsp - Hover")

  buf_map("n", "R", function()
    require("telescope.builtin").lsp_references({ show_line = false, include_declaration = false })
  end, "Lsp - [R]eferences")

  buf_map("n", "gt", function()
    vim.lsp.buf.type_definition()
    vim.fn.feedkeys("zz")
  end, "Lsp - [G]o to [T]ype definition")

  buf_map("n", "gI", function()
    vim.lsp.buf.implementation()
    vim.fn.feedkeys("zz")
  end, "Lsp - [G]o to [I]mplementation")
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
    attach_lsp_maps(client, bufnr)
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
  on_attach = attach_lsp_maps,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim", "hs" },
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

-- TODO: only works in cargo package, not in standalone .rs files
nvim_lsp.rust_analyzer.setup({
  on_attach = function(client, buffnr)
    attach_lsp_maps(client, buffnr)
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
  virtual_text = { spacing = 4, prefix = " ●" },
  severity_sort = true,
})
