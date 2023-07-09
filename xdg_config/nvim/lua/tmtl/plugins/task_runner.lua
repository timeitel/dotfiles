-- TODO: problem matchers / error formats
local M = {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    local overseer = require("overseer")
    local map = require("tmtl.utils").map

    local function get_ft()
      local currentBufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[currentBufnr].filetype
      return filetype
    end

    map("n", "gor", function()
      overseer.toggle()
    end, { desc = "Task [R]unner - toggle running tasks" })

    map("n", "<leader>rl", function()
      overseer.run_template()
    end, { desc = "Task [R]unner - toggle task [L]ist" })

    map("n", "<leader>rt", function()
      local ft = get_ft()
      if ft == "typescript" then
        vim.cmd([[TSC]]) -- TODO: move into this task runner and remove plugin
      else
        overseer.run_template({ name = "test:" .. get_ft() })
      end
    end, { desc = "Task [R]unner - run [T]est" })

    map("n", "<leader>rb", function()
      overseer.run_template({ name = "build:" .. get_ft() })
    end, { desc = "Task [R]unner - run [B]uild" })

    map("n", "<leader>ra", function()
      overseer.run_template({ name = "run:" .. get_ft() })
      overseer.open()
    end, { desc = "Task [R]unner - run [A]pp" })

    map("n", "<leader>rr", function()
      local tasks = overseer.list_tasks({ recent_first = true })
      if vim.tbl_isempty(tasks) then
        overseer.run_template({ name = "run:" .. get_ft() })
        overseer.open()
      else
        overseer.run_action(tasks[1], "restart")
      end
    end, { desc = "Task [R]unner - [R]erun last task" })

    overseer.setup({
      task_list = {
        default_detail = 2,
        bindings = {
          q = "<CMD>close<CR>",
        },
      },
      templates = {
        "builtin",
        "tasks.go-build",
        "tasks.go-run",
        "tasks.rust-build",
        "tasks.rust-run"
      }
    })
  end
}

return M
