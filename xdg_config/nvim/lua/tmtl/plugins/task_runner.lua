local M = {
  "stevearc/overseer.nvim",
  opts = {},
  config = function()
    local overseer = require("overseer")
    local map = require("tmtl.utils").map
    local contains = require("tmtl.utils").contains

    local function on_complete_subscribe(task)
      if task == nil then
        return
      end

      task:subscribe("on_complete", function(_, status)
        if status == "SUCCESS" and task.metadata.on_success ~= nil then
          task.metadata.on_success(task)
        elseif status == "FAILURE" and task.metadata.on_failure ~= nil then
          task.metadata.on_failure(task)
        end
      end)
    end

    local function get_ft()
      local currentBufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo[currentBufnr].filetype

      if contains({ "typescript", "typescriptreact", "javascript", "json" }, ft) then
        return "ts"
      end
      return ft
    end

    map("n", "gor", function()
      overseer.toggle()
    end, { desc = "Task [R]unner - toggle running tasks" })

    map("n", "<leader>rl", function()
      overseer.run_template({}, function(task)
        if string.find(task.cmd[3], "deploy") then
          overseer.run_action(task, 'open float')
        end
      end
      )
    end, { desc = "Task [R]unner - toggle task [L]ist" })

    map("n", "<leader>rt", function()
      overseer.run_template({ name = "test:" .. get_ft() }, on_complete_subscribe)
    end, { desc = "Task [R]unner - run [T]est" })

    map("n", "<leader>rb", function()
      overseer.run_template({ name = "build:" .. get_ft() }, on_complete_subscribe)
    end, { desc = "Task [R]unner - run [B]uild" })

    map("n", "<leader>ra", function()
      overseer.run_template({ name = "run:" .. get_ft() }, on_complete_subscribe)
    end, { desc = "Task [R]unner - run [A]pp" })

    map("n", "<leader>rr", function()
      local tasks = overseer.list_tasks({ recent_first = true })
      if vim.tbl_isempty(tasks) then
        overseer.run_template({ name = "run:" .. get_ft(), on_complete_subscribe })
      else
        overseer.run_action(tasks[1], "restart")
      end
    end, { desc = "Task [R]unner - [R]erun last task" })

    map("n", "<leader>rd", function()
      overseer.run_template({}, function(task)
        if task then
          overseer.run_action(task, 'open float')
        end
      end)

      vim.fn.feedkeys("ideploykj")
    end, { desc = "Task [R]unner - [D]eploy tasks" })

    overseer.setup({
      task_list = {
        default_detail = 2,
        bindings = {
          ["[t"] = "PrevTask",
          ["]t"] = "NextTask",
          ["p"] = "TogglePreview",
          ["q"] = "<CMD>close<CR>",
          ["<C-y>"] = "ScrollOutputUp",
          ["<C-e>"] = "ScrollOutputDown",
          ["<C-x>"] = "<CMD>OverseerQuickAction Dispose<CR>",
        },
      },

      actions = {
        ["Dispose"] = {
          run = function(task)
            task:dispose(true)
          end,
        },
      },

      templates = {
        "builtin",
        "tasks.go-build",
        "tasks.go-run",
        "tasks.go-test",
        "tasks.rust-build",
        "tasks.rust-run",
        "tasks.rust-test",
        "tasks.typescript-build",
        "tasks.git-discard-all",
        "tasks.git-undo-last-commit",
      },

      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          { "on_complete_notify", statuses = { "SUCCESS" } },
          "on_complete_dispose",
        },
      },
    })
  end,
}

return M
