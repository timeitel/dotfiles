local map = require("tmtl.utils").map

map("n", "<leader>gp", function()
  require("tmtl.utils").notify_command({ "git", "push" }, function()
    vim.cmd([[doautocmd user FugitiveChanged]])
  end)
end, { desc = "[G]it [P]ush" })
