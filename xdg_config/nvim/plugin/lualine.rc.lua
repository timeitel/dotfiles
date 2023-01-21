local colors = {
  red = "#cdd6f4",
  grey = "#181825",
  black = "#1e1e2e",
  white = "#313244",
  light_green = "#6c7086",
  orange = "#fab387",
  green = "#a6e3a1",
  blue = "#80A7EA",
  innerbg = nil,
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.innerbg },
    b = { fg = colors.blue, bg = colors.innerbg },
    c = { fg = colors.white, bg = colors.innerbg },
    z = { fg = colors.white, bg = colors.innerbg },
  },
  inactive = {
    a = { fg = colors.gray, bg = colors.outerbg },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  insert = { a = { fg = colors.black, bg = colors.innerbg } },
  visual = { a = { fg = colors.black, bg = colors.innerbg } },
  replace = { a = { fg = colors.black, bg = colors.innerbg } },
}

-- local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
--   return function(str)
--     local win_width = vim.fn.winwidth(0)
--     if hide_width and win_width < hide_width then
--       return ""
--     elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
--       return str:sub(1, trunc_len) .. (no_ellipsis and "" or "..")
--     end
--     return str
--   end
-- end

-- TODO: change to just icon on the right
local function show_unsaved_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "modified") then
      return "[+]"
    end
  end
  return ""
end

local filename = {
  "filename",
  color = { bg = "#82aaff", fg = "#313244" },
  separator = { left = "", right = "" },
}

local inactive_filename = {
  "filename",
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  color = { bg = "#82aaff", fg = "#313244" },
  separator = { left = "", right = "" },
}

local diff = {
  "diff",
  colored = false,
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = "", right = "" },
}

local dia = {
  "diagnostics",
  colored = false,
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = "", right = "" },
}

require("lualine").setup({
  options = {
    theme = theme,
    icons_enabled = true,
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
    lualine_a = { branch, diff },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { dia, filename, filetype },
  },
  inactive_sections = {
    lualine_a = { inactive_filename },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
