local M = {}

M.map = function(m, k, v, opts)
  opts = opts or {}
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

M.assign_to_next_prev = function(next, prev)
  M.map("n", "<tab>", next, { desc = "Next - special" })
  M.map("n", "<S-tab>", prev, { desc = "Previous - special" })
end

-- TODO: use like in hx
M.assign_to_repeat_cmd = function(cmd)
  M.map("n", "<C-.>", cmd, { desc = "Repeat command" })
end

return M
