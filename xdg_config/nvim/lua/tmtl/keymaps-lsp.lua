local assign_to_next_prev = require("tmtl.utils").assign_to_next_prev

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local function goto_diagnostic(opts)
  opts = opts or {}
  local prev = opts.prev or false

  if prev then
    vim.diagnostic.goto_prev({ float = { border = border }, severity = opts.severity })
  else
    vim.diagnostic.goto_next({ float = { border = border }, severity = opts.severity })
  end

  vim.fn.feedkeys("zz")
end

-- Default next_prev action to next_diagnostic
assign_to_next_prev(function()
  goto_diagnostic({ severity = vim.diagnostic.severity.ERROR })
end, function()
  goto_diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
end)

local M = {}

M.attach = function(bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr, desc = d })
  end

  -- TODO: 1. <leader>dh if no code actions
  -- TODO: 2. floating diag window max width
  -- Diagnostics
  buf_map("n", "<leader>dj", function()
    assign_to_next_prev(function()
      goto_diagnostic({ severity = vim.diagnostic.severity.ERROR })
    end, function()
      goto_diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
    end)

    goto_diagnostic({ severity = vim.diagnostic.severity.ERROR })
  end, "[D]iagnostics - next error")

  buf_map("n", "<leader><leader>dj", function()
    assign_to_next_prev(goto_diagnostic, function()
      goto_diagnostic({ prev = true })
    end)

    goto_diagnostic()
  end, "[D]iagnostics - next diagnostic")

  buf_map("n", "<leader>dk", function()
    assign_to_next_prev(function()
      goto_diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
    end, function()
      goto_diagnostic({ severity = vim.diagnostic.severity.ERROR })
    end)

    goto_diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
  end, "[D]iagnostics - previous error")

  buf_map("n", "<leader><leader>dk", function()
    assign_to_next_prev(function()
      goto_diagnostic({ prev = true })
    end, goto_diagnostic)

    goto_diagnostic({ prev = true })
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
  end, "[L]sp - [R]estart")

  -- TODO: change to toggle with ls, check if needing to stop or start
  buf_map("n", "<leader>ls", function()
    vim.cmd([[LspStop]])
  end, "[L]sp - [S]top")

  buf_map("n", "<leader><leader>ls", function()
    vim.cmd([[LspStart]])
  end, "[L]sp - [S]tart")

  buf_map("n", "<leader>li", function()
    vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
  end, "[L]sp - organize [I]mports")

  buf_map({ "i", "n" }, "<C-S-Space>", function()
    vim.lsp.buf.signature_help()
  end, "Lsp - signature")

  buf_map("n", "gd", function()
    vim.lsp.buf.definition()

    vim.defer_fn(function()
      vim.fn.feedkeys("zz")
    end, 10)
  end, "Lsp - [G]o to [D]efinition")

  buf_map("n", "gD", function()
    vim.cmd([[vs]])
    vim.lsp.buf.definition()

    vim.defer_fn(function()
      vim.fn.feedkeys("zz")
    end, 10)
  end, "Lsp - [G]o to [D]efinition in vertical split")

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

return M
