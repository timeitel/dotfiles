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

M.change_case = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand("<cword>")
  local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

  -- Detect camelCase
  if word:find("[a-z][A-Z]") then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
    -- Detect snake_case
  elseif word:find("_[a-z]") then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub("(_)([a-z])", function(_, l)
      return l:upper()
    end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    print("Not a snake_case or camelCase word")
  end
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
      notify(error_output, "error")
    end
    if #output == 0 and #error_output == 0 then
      notify("No output of command, exit code: " .. code, "warn")
    end

    if cb and type(cb) == "function" then
      cb()
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

return M
