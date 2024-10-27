local map = require("tmtl.utils").map
local request_confirm = require("tmtl.utils").request_confirm
local notify = require("notify")

map("n", "<leader>gp", function()
  require("tmtl.utils").notify_command({ "git", "push" }, function()
    vim.cmd([[doautocmd user FugitiveChanged]])
  end)
end, { desc = "[G]it [P]ush" })

map("n", "<leader>gu", function()
  request_confirm({
    prompt = "undo last commit",
    on_confirm = function()
      require("overseer").run_template({ name = "git:undo_last_commit" }, function()
        vim.cmd([[doautocmd user FugitiveChanged]])
      end)
    end,
  })
end, { desc = "[G]it [U]ndo - last commit into working directory" })

map("n", "<leader>gx", function()
  request_confirm({
    prompt = "discard ALL working changes",
    on_confirm = function()
      require("overseer").run_template({ name = "git:discard_all" }, function(_, err)
        if err == nil then
          vim.defer_fn(function()
            vim.cmd([[checktime]])
          end, 100)
        else
          notify("Error discarding all changes", vim.log.levels.ERROR)
        end
      end)
    end,
  })
end, { desc = "[G]it Reset: discard ALL working changes" })
