local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

bufferline.setup({
  options = {
    mode = "tabs",
    buffer_close_icon = "",
    show_duplicate_prefix = false,
    max_name_length = 30,
    always_show_bufferline = false,
  },
})
