local M = {
  "nvim-lualine/lualine.nvim",
  config = function()
    local parser = require("overseer.parser")
    local kanagawa_colors = require("kanagawa.colors").setup()
    local theme_colors = kanagawa_colors.theme
    local palette = kanagawa_colors.palette
    local lualine = require("lualine")
    local spread_table = require("tmtl.utils").spread_table
    local custom_theme = require("lualine.themes.auto")

    custom_theme.insert.a.bg = palette.dragonBlue
    custom_theme.insert.b.fg = palette.dragonBlue
    custom_theme.normal.c.bg = "NONE"
    custom_theme.inactive.c.bg = "NONE"

    local BG_NONE = { bg = "NONE" }

    local global_line_filename = {
      "filename",
      fmt = function(str)
        if string.find(str, "zsh;") ~= nil then
          local mode = vim.fn.mode()
          local formatted_mode = mode == "n" and "NORMAL" or "INSERT"
          return "Terminal" .. " [" .. formatted_mode .. "]"
        end
        return str
      end,
      color = BG_NONE,
      padding = { left = 0 },
    }

    local function winbar_title(str)
      local currentBufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[currentBufnr].filetype

      if filetype == "OverseerList" then
        return "Tasks"
      end

      if
        (string.find(str, ".git/") ~= nil or string.find(str, "/worktrees/") ~= nil)
        and string.find(str, ":3:/") ~= nil
      then
        return "THEIRS"
      end

      if
        (string.find(str, ".git/") ~= nil or string.find(str, "/worktrees/") ~= nil)
        and string.find(str, ":2:/") ~= nil
      then
        return "OURS"
      end

      if string.find(str, "term://") ~= nil then
        return ""
      end

      return str
    end

    local winbar_filename = {
      "filename",
      color = { bg = "NONE", fg = palette.dragonBlue2 },
      fmt = winbar_title,
      path = 1,
    }

    local winbar_inactive_filename = spread_table({}, winbar_filename)
    winbar_inactive_filename.color = { bg = "NONE", fg = theme_colors.syn.comment }

    local filetype = {
      "filetype",
      icon_only = true,
      colored = false,
      padding = { left = 0, right = 0 },
      color = BG_NONE,
    }

    local padding = {
      function()
        return " "
      end,
      padding = { left = 1 },
      color = BG_NONE,
    }

    local diagnostic_stats = {
      "diagnostics",
      colored = false,
      color = BG_NONE,
    }

    local lsp = {
      function()
        local msg = "No LSP"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return " " .. client.name
          end
        end
        return " " .. msg
      end,
      separator = { left = "", right = "" },
    }

    local search_count = {
      function()
        -- searchcount can fail e.g. if unbalanced braces in search pattern
        if vim.v.hlsearch == 1 then
          local ok, searchcount = pcall(vim.fn.searchcount)

          if ok and searchcount["total"] > 0 then
            return "⚲ " .. searchcount["current"] .. "/" .. searchcount["total"] .. " "
          end
        end

        return ""
      end,
    }

    local macro_recording = {
      function()
        local recording_register = vim.fn.reg_recording()

        if recording_register == "" then
          return ""
        else
          return "rec @" .. recording_register .. " "
        end
      end,
    }

    local cwd = {
      function()
        return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
    }

    local task_runner = {
      "overseer",
      colored = false,
      status = { parser.STATUS.RUNNING },
    }

    local dap = {
      function()
        local session = require("dap").session()
        if session ~= nil then
          return "● DEBUGGING"
        else
          return ""
        end
      end,
      color = { bg = palette.winterRed, fg = palette.fujiWhite },
      separator = { left = "", right = "" },
    }

    local git_prompt_string = {
      "git_prompt_string",
      separator = { left = "", right = "" },
      prompt_config = {
        color_disabled = true,
      },
    }

    lualine.setup({
      options = {
        theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "DiffviewFiles", "DiffviewFileHistory" },
          winbar = { "DiffviewFiles", "DiffviewFileHistory", "qf" },
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
        lualine_a = { cwd, git_prompt_string },
        lualine_b = { padding, filetype, global_line_filename },
        lualine_c = {},
        lualine_x = { search_count, macro_recording, task_runner },
        lualine_y = { diagnostic_stats },
        lualine_z = { lsp, dap },
      },
      inactive_sections = {},
      tabline = {},
      winbar = {
        lualine_z = { winbar_filename },
      },
      inactive_winbar = {
        lualine_x = {},
        lualine_z = {
          {
            "diagnostics",
            colored = false,
            color = { bg = "NONE", fg = theme_colors.syn.comment },
          },
          winbar_inactive_filename,
        },
      },
      extensions = {},
    })
  end,
}

return M
