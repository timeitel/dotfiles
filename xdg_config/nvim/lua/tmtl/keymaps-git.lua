local map = require("tmtl.utils").map
local request_confirm = require("tmtl.utils").request_confirm
local ts = require("telescope.builtin")
local neogit = require("neogit")
local notify = require("notify")

map("n", "<leader>gs", function()
  neogit.open()
end, { desc = "[G]it [S]tatus" })

map("n", "<leader><leader>gs", function()
  ts.git_stash()
end, { desc = "[G]it [S]tash" })

map("n", "<leader>gd", function()
  vim.cmd([[DiffviewOpen]])
end, { desc = "[G]it [D]iff" })

map("n", "<leader><leader>gd", function()
  vim.cmd([[DiffviewOpen origin/dev...HEAD]])
  notify('Opening diff: "origin/dev...HEAD"')
end, { desc = "[G]it [D]iff - HEAD against origin/dev" })

map(
  "n",
  "<leader><leader><leader>gd",
  ":DiffviewOpen origin/{target}...HEAD",
  { desc = "[G]it [D]iff - Choose target comparison against HEAD" }
)

map("n", "<leader>gh", function()
  vim.cmd([[DiffviewFileHistory]])
end, { desc = "[G]it [H]istory" })

map("n", "<leader>gfh", function()
  vim.cmd([[DiffviewFileHistory %]])
end, { desc = "[G]it [F]ile [H]istory" })

map("n", "<leader>gfx", function()
  vim.cmd([[Gitsigns reset_buffer]])
  notify("Discarded changes of current file", vim.log.levels.WARN)
end, { desc = "[G]it [F]ile - discard changes" })

map("n", "<leader>gb", function()
  ts.git_branches()
end, { desc = "[G]it [B]ranches" })

map("n", "<leader>gu", function()
  request_confirm({
    prompt = "undo last commit",
    on_confirm = function()
      require("overseer").run_template({ name = "git:undo_last_commit" })
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
end, { desc = "[G]it [R]eset: discard ALL working changes" })

map("n", "<leader><leader>gb", ":BlameToggle virtual<cr>", { desc = "[G]it [B]lame" })

map("n", "<C-j>", function()
  vim.cmd([[Gitsigns next_hunk]])
end, { desc = "Git [H]unk - next" })

map("n", "<C-k>", function()
  vim.cmd([[Gitsigns prev_hunk]])
end, { desc = "Git [H]unk - previous" })

map({ "n", "v" }, "<leader>hp", function()
  vim.cmd([[Gitsigns preview_hunk]])
end, { desc = "Git [H]unk [P]review" })

map({ "n", "v" }, "<leader>hs", function()
  vim.cmd([[Gitsigns stage_hunk]])
  notify("Staged hunk")
end, { desc = "Git [H]unk [S]tage" })

map("n", "<leader>hx", function()
  vim.cmd([[Gitsigns reset_hunk]])
  notify("Discarded hunk", vim.log.levels.WARN)
end, { desc = "Git [H]unk - discard" })

map("v", "<leader>hx", function()
  vim.fn.feedkeys(":Gitsigns reset_hunk")
  vim.api.nvim_input("<cr>")
  notify("Discarded hunk range", vim.log.levels.WARN)
end, { desc = "Git [H]unk - discard" })

map("n", "<leader>hu", function()
  vim.cmd([[Gitsigns undo_stage_hunk]])
  notify("Unstaged the last staged hunk")
end, { desc = "Git [H]unk [U]ndo - last staged hunk" })

map("n", "<leader>gwc", function()
  vim.fn.feedkeys(":lua require('git-worktree').create_worktree('../{folder}', '{branch}', 'origin')")
  vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-f>"'))
  vim.fn.feedkeys("F/a")
end, { desc = "[G]it [W]orktree [C]reate" })
