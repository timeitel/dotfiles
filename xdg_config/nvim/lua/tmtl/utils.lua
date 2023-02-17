Utils = {}

Utils.map = function(m, k, v, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  vim.keymap.set(m, k, v, opts)
end

Utils.getVisualSelection = function()
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

Utils.shallow_copy = function(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

Utils.assign_to_next_prev = function(next, prev)
	Utils.map("n", "<tab>", next, { desc = "Next - special" })
	Utils.map("n", "<S-tab>", prev, { desc = "Previous - special" })
end
