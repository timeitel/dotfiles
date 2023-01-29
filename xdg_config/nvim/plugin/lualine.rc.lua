local colors = {
  blue = "#313244",
  gray = "#82aaff",
  green = "41a6b5",
  gunmetal = "#282c34",
  yellow = "#e0af68",
  magenta = "#bb9af7",
  cyan = "#7dcfff",
}

local function get_normal_mode_colors(primary)
  return {
    a = { bg = colors.gray, fg = primary },
    b = { bg = primary, fg = colors.gray },
    c = { bg = colors.gunmetal, fg = colors.gunmetal },
    x = { bg = primary, fg = colors.gray },
    y = { bg = colors.gray, fg = primary },
    z = { bg = primary, fg = colors.gray },
  }
end

local function get_mode_colors(primary)
  return {
    a = { bg = primary, fg = colors.gunmetal },
    b = { bg = colors.gunmetal, fg = primary },
    x = { bg = colors.gunmetal, fg = primary },
    y = { bg = primary, fg = colors.gunmetal },
    z = { bg = colors.gunmetal, fg = primary },
  }
end

local theme = {
  normal = get_normal_mode_colors(colors.blue),
  insert = get_mode_colors(colors.green),
  visual = get_mode_colors(colors.magenta),
  replace = get_mode_colors(colors.cyan),
  command = get_mode_colors(colors.yellow),
}

-- TODO: change to just icon on the right
-- local function show_unsaved_buffers()
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_get_option(buf, "modified") then
--       return "[+]"
--     end
--   end
--   return ""
-- end

local filename = {
  "filename",
  separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = false,
  separator = { left = "", right = "" },
  padding = { right = -3, left = 1 },
}

local branch = {
  "branch",
  separator = { left = "", right = "" },
}

local diff = {
  "diff",
  colored = false,
  separator = { left = "", right = "" },
}

local dia = {
  "diagnostics",
  colored = false,
  separator = { left = "", right = "" },
}

function GetCurrentDiagnostic()
  local bufnr = 0
  local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
  local opts = { ["lnum"] = line_nr }

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  local best_diagnostic = nil

  for _, diagnostic in ipairs(line_diagnostics) do
    if best_diagnostic == nil or diagnostic.severity < best_diagnostic.severity then
      best_diagnostic = diagnostic
    end
  end

  return best_diagnostic
end

function GetCurrentDiagnosticString()
  local diagnostic = GetCurrentDiagnostic()

  if not diagnostic or not diagnostic.message then
    return
  end

  local message = vim.split(diagnostic.message, "\n")[1]
  local max_width = vim.api.nvim_win_get_width(0) - 35

  if string.len(message) < max_width then
    return message
  else
    return string.sub(message, 1, max_width) .. "..."
  end
end

local function getLspName()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return "  " .. client.name
    end
  end
  return "  " .. msg
end

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = "", right = "" },
}

require("lualine").setup({
  options = {
    theme = theme,
    icons_enabled = true,
    disabled_filetypes = {
      statusline = { "DiffviewFiles", "DiffviewFileHistory" },
      winbar = { "DiffviewFiles", "DiffviewFileHistory" },
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { branch },
    lualine_b = { diff },
    lualine_c = { "GetCurrentDiagnosticString()" },
    lualine_x = {},
    lualine_y = { dia },
    lualine_z = { lsp },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {
    lualine_x = { dia },
    lualine_z = { filetype, filename },
  },
  inactive_winbar = {
    lualine_x = { dia },
    lualine_z = { filetype, filename },
  },
  extensions = {},
})
