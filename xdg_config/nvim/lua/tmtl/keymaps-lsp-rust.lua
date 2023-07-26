local border = require("tmtl.utils").border

local M = {}

M.attach = function(bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr or 0, desc = d })
  end

  buf_map("n", "]s", "<cmd>DapStepOver<cr>", "Diagnostics - step over")

  buf_map("n", "]c", "<cmd>DapContinue<cr>", "Diagnostics - step over")

  buf_map("n", "<leader>dr", "<cmd>lua require('dap').restart()<cr>", "[D]iagnostics - [R]estart")

  buf_map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", "[D]ebugger - toggle breakpoint")

  buf_map("n", "<leader>dd", "<cmd>RustDebuggables<cr>", "[D]ebugger - run")

  -- TODO: only assign while debugging session is active
  buf_map("n", "<leader><leader>dh", function()
    require("dap.ui.widgets").hover(nil, { border = border })
  end, "[D]ebugger - [H]over")
end

return M

