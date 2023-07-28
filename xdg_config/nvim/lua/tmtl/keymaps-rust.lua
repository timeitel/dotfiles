local border = require("tmtl.utils").border

local M = {}

M.attach = function(bufnr)
  local dap = require('dap')
  local widgets = require('dap.ui.widgets')
  local win_width = vim.fn.winwidth(0) / 2
  local sidebar = widgets.sidebar(widgets.scopes, { width = math.floor(win_width) })
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr or 0, desc = d })
  end

  dap.defaults.fallback.terminal_win_cmd = 'tabnew'

  local function start_or_continue()
    if dap.session() ~= nil then
      dap.continue()
    else
      vim.cmd([[RustDebuggables]])
    end
  end

  -- Session
  buf_map("n", "<F5>", start_or_continue, "[D]ebugger start or continue")
  buf_map("n", "<M-b>", "<cmd>DapToggleBreakpoint<cr>", "[D]ebugger toggle [B]reakpoint")
  buf_map("n", "<F9>", "<cmd>DapToggleBreakpoint<cr>", "[D]ebugger toggle [B]reakpoint")
  buf_map("n", "<F10>", function() dap.step_over() end, "[D]ebugger step over")
  buf_map("n", "<F11>", function() dap.step_into() end, "[D]ebugger step in")
  buf_map("n", "<F12>", function() dap.step_out() end, "[D]ebugger step out")

  -- Commands
  buf_map("n", "<leader>dr", function() dap.restart() end, "[D]ebugger [R]estart")
  buf_map("n", "<leader>ds", function()
    if dap.session() ~= nil then
      dap.terminate()
      sidebar.close()
    else
      sidebar.open()
      vim.cmd([[RustDebuggables]])
    end
  end, "[D]ebugger [S]tart / [S]top")
  buf_map("n", "<leader>db", function() dap.clear_breakpoints() end, "[D]ebugger clear [B]reakpoints")
  buf_map("n", "<leader>dc", function() dap.run_to_cursor() end, "[D]ebugger run to [C]ursor")
  local inlay_hints = true
  buf_map("n", "<leader>lh", function()
    if inlay_hints then
      require('rust-tools').inlay_hints.unset()
      inlay_hints = false
    else
      require('rust-tools').inlay_hints.set()
      inlay_hints = true
    end
  end, "[L]SP [H]ints")

  -- UI
  buf_map({ 'n', 'v' }, '<Leader>dl', sidebar.open, "[D]ebugger scope [List]")
  buf_map('n', '<Leader>df', function() widgets.centered_float(widgets.scopes) end, "[D]ebugger [F]loat")
  buf_map("n", "<leader>de", function() widgets.hover(nil, { border = border }) end, "[D]ebugger [E]xpression")
end

return M
