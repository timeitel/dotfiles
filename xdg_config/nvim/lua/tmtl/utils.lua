local M = {}

M.map = function(m, k, v, options)
  local opts = options or {}
  opts.silent = true
  opts.noremap = true
  vim.keymap.set(m, k, v, opts)
end

M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

M.shallow_copy = function(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

M.request_confirm = function(options)
  local opts = options or {}
  local on_confirm = opts.on_confirm
  local on_reject = opts.on_reject
  local prompt = "Are you sure you'd like to " .. opts.prompt .. "? (&Yes\n&No)"

  if vim.fn.confirm("", prompt, 1) == 1 then
    on_confirm()
  elseif on_reject ~= nil then
    on_reject()
  end
end

M.spread_table = function(target_table, source_table, source_table_2)
  local source_2 = source_table_2 or {}
  for k, v in pairs(source_table) do
    target_table[k] = v
  end

  for k, v in pairs(source_2) do
    target_table[k] = v
  end
  return target_table
end

M.contains = function(table, value)
  for _, table_value in ipairs(table) do
    if table_value == value then
      return true
    end
  end

  return false
end

M.table_length = function(table)
  local count = 0
  for _ in pairs(table) do
    count = count + 1
  end
  return count
end

-- @param command function A shell command to be called and output passed to notify.
-- @param cb function|nil A callback function to be called after command.
-- @return nil
M.notify_command = function(command, cb)
  local stdin = vim.loop.new_pipe()
  local stdout = vim.loop.new_pipe()
  local stderr = vim.loop.new_pipe()
  local output = ""
  local error_output = ""
  local notify = function(msg, level)
    vim.notify(msg, level, { title = table.concat(command, " ") })
  end

  vim.loop.spawn(command[1], {
    stdio = { stdin, stdout, stderr },
    detached = true,
    args = #command > 1 and vim.list_slice(command, 2, #command) or nil,
  }, function(code, _)
    stdin:close()
    stdout:close()
    stderr:close()
    if #output > 0 then
      notify(output)
    end
    if #error_output > 0 then
      notify(error_output, vim.log.levels.INFO)
    end
    if #output == 0 and #error_output == 0 then
      notify("No output of command, exit code: " .. code, vim.log.levels.WARN)
    end

    if cb and type(cb) == "function" then
      vim.schedule(function()
        cb()
      end)
    end
  end)

  stdout:read_start(function(err, data)
    if err then
      error_output = error_output .. (err or data)
      return
    end
    if data then
      output = output .. data
    end
  end)
  stderr:read_start(function(err, data)
    if err or data then
      error_output = error_output .. (err or data)
    end
  end)
end

M.winenter_once = function(cb)
  vim.api.nvim_create_autocmd("WinEnter", {
    once = true,
    pattern = "*",
    callback = function()
      if type(cb) == "function" then
        cb()
      else
        vim.fn.feedkeys(cb)
      end
    end,
  })
end

local function goto_diagnostic(opts)
  local table_length = require("tmtl.utils").table_length
  opts = opts or {}
  local prev = opts.prev or false
  local float = opts.float or false

  if prev then
    vim.diagnostic.goto_prev({ float = false, severity = opts.severity })
  else
    vim.diagnostic.goto_next({ float = false, severity = opts.severity })
  end

  if float then
    vim.defer_fn(function()
      vim.diagnostic.open_float({ severity_sort = true, border = "rounded" })
    end, 50)
  end

  local diagnostic_count = table_length(vim.diagnostic.get(0))
  if diagnostic_count == 0 then
    require("notify")("No more diagnostics")
  end
end

M.on_attach_lsp = function(client, bufnr)
  local function buf_map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr or 0, desc = d })
  end

  buf_map("n", "]e", function()
    goto_diagnostic({ severity = vim.diagnostic.severity.ERROR })
  end, "Next [E]rror")

  buf_map("n", "[e", function()
    goto_diagnostic({ prev = true, severity = vim.diagnostic.severity.ERROR })
  end, "Previous [E]rror")

  buf_map("n", "<C-n>", function()
    goto_diagnostic({ float = true, severity = { min = vim.diagnostic.severity.HINT } })
  end, "[N]ext diagnostic")

  buf_map("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, "[L]SP code [A]ctions")

  buf_map("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, "[L]SP [H]ints toggle")

  buf_map("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, "[L]SP [R]ename")

  buf_map("n", "<leader>li", function()
    vim.cmd([[OrganizeImports]])
  end, "[L]SP organize [I]mports")

  buf_map("n", "<leader><leader>lr", function()
    vim.cmd([[LspRestart]])
  end, "[L]SP [R]estart")

  buf_map("n", "<leader><leader>li", function()
    vim.cmd([[LspInfo]])
  end, "[L]SP [I]nfo")

  buf_map("n", "<leader><leader>ls", function()
    -- TODO: change to toggle with ls, check if needing to stop or start
    vim.cmd([[LspStop]])
  end, "[L]SP [S]top")

  buf_map("n", "<leader><leader>lr", function()
    vim.cmd([[LspRestart]])
  end, "[L]SP [R]estart")

  buf_map({ "i", "n" }, "<C-S-Space>", function()
    vim.lsp.buf.signature_help()
  end, "Lsp signature")

  buf_map("n", "gd", function()
    -- TODO: look into awaiting definition before centering
    vim.lsp.buf.definition()

    vim.defer_fn(function()
      vim.fn.feedkeys("zz")
    end, 100)
  end, "Lsp [G]o to [D]efinition")

  buf_map("n", "gov", function()
    -- TODO: look into awaiting definition before centering
    vim.cmd([[only]])
    vim.cmd([[vs]])
    vim.lsp.buf.definition()

    vim.defer_fn(function()
      vim.fn.feedkeys("zz")
    end, 100)
  end, "Lsp [G]o to [D]efinition in vertical split")

  buf_map("n", "R", function()
    require("telescope.builtin").lsp_references({ show_line = false, include_declaration = false })
  end, "Lsp [R]eferences")

  buf_map("n", "gt", function()
    vim.lsp.buf.type_definition()
    vim.fn.feedkeys("zz")
  end, "Lsp [G]o to [T]ype definition")

  buf_map("n", "gI", function()
    vim.lsp.buf.implementation()
    vim.fn.feedkeys("zz")
  end, "Lsp [G]o to [I]mplementation")
end

return M
