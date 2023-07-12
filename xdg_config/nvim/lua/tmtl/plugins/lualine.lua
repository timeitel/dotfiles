local M = {
  "nvim-lualine/lualine.nvim",
  config = function()
    local parser = require("overseer.parser")
    local kanagawa_colors = require("kanagawa.colors").setup()
    local palette_colors = kanagawa_colors.palette
    local theme_colors = kanagawa_colors.theme
    local lualine = require("lualine")
    local spread_table = require("tmtl.utils").spread_table

    local colors = {
      blue = palette_colors.crystalBlue,
      gray = palette_colors.sumiInk3,
      green = palette_colors.autumnGreen,
      gunmetal = "#282c34",
      yellow = palette_colors.autumnYellow,
      magenta = palette_colors.crystalBlue,
      cyan = palette_colors.dragonBlue,
    }
    local secondary_blue = { bg = colors.blue, fg = colors.gray }

    local function get_normal_mode_colors(primary)
      local color = { bg = colors.gray, fg = primary }
      return {
        a = color,
        b = color,
        c = { bg = colors.gunmetal, fg = theme_colors.syn.comment },
        x = color,
        y = color,
      }
    end

    local function get_mode_colors(primary)
      local color = { bg = colors.gunmetal, fg = primary }
      return {
        a = color,
        b = color,
        x = color,
        y = color,
      }
    end

    local theme = {
      normal = get_normal_mode_colors(colors.blue),
      insert = get_mode_colors(colors.magenta),
      visual = get_mode_colors(colors.magenta),
      replace = get_mode_colors(colors.cyan),
      command = get_mode_colors(colors.yellow),
    }

    local global_line_filename = {
      "filename",
      -- TODO: either show cursor diff3rent in insert mode in terminal or add mode to lualine
      separator = { left = "", right = "" },
      fmt = function(str)
        if string.find(str, 'zsh;') ~= nil then
          return "Terminal"
        end
        return str
      end
    }

    local function winbar_title(str)
      local currentBufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[currentBufnr].filetype

      if filetype == "OverseerList" then
        return "Tasks"
      end

      if (string.find(str, '.git/') ~= nil or string.find(str, '/worktrees/') ~= nil) and
          string.find(str, ':3:/') ~= nil then
        return "THEIRS"
      end

      if (string.find(str, '.git/') ~= nil or string.find(str, '/worktrees/') ~= nil)
          and string.find(str, ':2:/') ~= nil then
        return "OURS"
      end

      if string.find(str, 'term://') ~= nil then
        return ""
      end

      return str
    end

    local winbar_filename = {
      "filename",
      color = secondary_blue,
      fmt = winbar_title,
      path = 1,
      separator = { left = "", right = "" },
    }

    local winbar_inactive_filename = spread_table({}, winbar_filename)
    winbar_inactive_filename.color = { bg = colors.gray, fg = colors.blue }

    local filetype = {
      "filetype",
      icon_only = true,
      colored = false,
      padding = { right = 0, left = 2 },
      separator = { left = "", right = "" },
    }

    local branch = {
      "branch",
      separator = { left = "", right = "" },
      color = secondary_blue,
    }

    local diagnostic_stats = {
      "diagnostics",
      colored = false,
      separator = { left = "", right = "" },
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
            return "  " .. client.name
          end
        end
        return "  " .. msg
      end,
      separator = { left = "", right = "" },
      color = secondary_blue,
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
      separator = { left = "", right = "" },
      color = secondary_blue,
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
      separator = { left = "", right = "" },
    }

    local lsp_progress = {
      "lsp_progress",
      display_components = { { "title", "percentage" } },
      timer = { progress_enddelay = 1000, lsp_client_name_enddelay = 1000 },
    }

    local worktree = {
      function()
        return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
      color = secondary_blue,
    }

    local task_runner = {
      "overseer",
      colored = false,
      status = { parser.STATUS.RUNNING },
      color = secondary_blue,
      separator = { left = "", right = "" },
    }

    lualine.setup({
      options = {
        theme = theme,
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
        lualine_a = { worktree, branch },
        lualine_b = { filetype, global_line_filename },
        lualine_c = {},
        lualine_x = { search_count, macro_recording, task_runner },
        lualine_y = { diagnostic_stats },
        lualine_z = { lsp, lsp_progress },
      },
      inactive_sections = {},
      tabline = {},
      winbar = {
        lualine_z = { winbar_filename },
      },
      inactive_winbar = {
        lualine_x = { diagnostic_stats },
        lualine_z = { winbar_inactive_filename },
      },
      extensions = {},
    })
  end,
}

return M
