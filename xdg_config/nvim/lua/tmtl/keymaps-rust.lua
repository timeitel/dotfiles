local border = require("tmtl.utils").border

local M = {}

M.attach = function(bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr or 0, desc = d })
  end

  local function start_or_continue()
    local session = require('dap').session()

    if session ~= nil then
      require('dap').continue()
    else
      vim.cmd([[RustDebuggables]])
    end
  end

  -- Session
  buf_map("n", "<leader>dd", start_or_continue, "[D]ebugger start or continue")
  buf_map("n", "<F5>", start_or_continue, "[D]ebugger start or continue")
  buf_map("n", "<F9>", "<cmd>DapToggleBreakpoint<cr>", "[D]ebugger toggle [B]reakpoint")
  buf_map("n", "<F10>", function() require('dap').step_over() end, "[D]ebugger step over")
  buf_map("n", "<F11>", function() require('dap').step_into() end, "[D]ebugger step in")
  buf_map("n", "<F12>", function() require('dap').step_out() end, "[D]ebugger step out")

  -- Commands
  buf_map("n", "<leader>dr", "<cmd>lua require('dap').restart()<cr>", "[D]ebugger [R]estart")
  buf_map("n", "<leader>dq", "<cmd>DapTerminate<cr>", "[D]ebugger [Q]uit")
  buf_map("n", "<leader>de", function() require('dap').repl.toggle() end, "[D]ebugger r[E]pl")
  buf_map("n", "<leader>db", function() require('dap').clear_breakpoints() end, "[D]ebugger clear [B]reakpoints")
  buf_map("n", "<leader>dc", function() require('dap').run_to_cursor() end, "[D]ebugger run to [C]ursor")
  local inlay_hints = true
  buf_map("n", "<leader>lh", function()
    if inlay_hints then
      require('rust-tools').inlay_hints.unset()
      inlay_hints = false
    else
      require('rust-tools').inlay_hints.set()
      inlay_hints = true
    end
  end, "[L]SP - [H]ints")

  -- UI
  buf_map({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end,
    "[D]ebugger [P]review in buffer")
  buf_map('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, "[D]ebugger [S]copes")
  buf_map("n", "<leader><leader>dh", function()
    require("dap.ui.widgets").hover(nil, { border = border })
  end, "[D]ebugger - [H]over")
end

return M
