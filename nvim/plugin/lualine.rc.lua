local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "..")
    end
    return str
  end
end

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    component_separators = "|",
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "DiffviewFiles", "DiffviewFileHistory" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      {
        "branch",
        fmt = trunc(100, 20, 80, false),
        separator = { left = "" },
      },
      {
        "diff",
        colored = false,
        separator = { right = "" },
      },
    },
    lualine_b = { "filename", "diagnostics" },
    lualine_c = {
      {
        "macro-recording",
        fmt = show_macro_recording,
      },
    },
    lualine_x = { "searchcount" },
    lualine_y = { "progress" },
    lualine_z = {
      { "filetype", separator = { right = "" }, icon_only = true, colored = false },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
