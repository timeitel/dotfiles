local ok, nvim_surround = pcall(require, "nvim-surround")
if not ok then
  return
end

local buffer_ok, buffer = pcall(require, "nvim-surround.buffer")
if not buffer_ok then
  return
end

nvim_surround.setup()

-- Don't alter indent after edit
buffer.format_lines = function(_, _) end
