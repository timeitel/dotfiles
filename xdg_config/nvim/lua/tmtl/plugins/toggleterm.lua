local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-;>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      autochdir = true,
    })

    local map = require("tmtl.utils").map

    map("n", "<leader>rw", function()
      vim.cmd([[ TermExec cmd="docker compose up --watch" name="Docker Watcher" ]])
    end, { desc = "[R]un [W]atcher" })

    map("n", "<leader>gp", function()
      local unpushed_commits = vim.fn.systemlist("git cherry")
      local notify = require("notify")
      local commits = table.getn(unpushed_commits)

      if commits == 0 then
        return notify("No commits to push")
      end

      notify("Pushing commits: " .. commits)
      -- TODO: sometimes not submiting - command left in terminal without <CR>
      vim.cmd([[ 10TermExec cmd="git push" name="Git Push" open=0 ]])
      vim.cmd([[doautocmd user FugitiveChanged]])
    end, { desc = "[G]it [P]ush" })
  end,
}

return M
