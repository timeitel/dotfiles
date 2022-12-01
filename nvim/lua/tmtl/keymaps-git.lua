local map = Utils.map
local ts = require("telescope.builtin")
local diffview_actions = require("diffview.actions")
local neogit = require("neogit")

map("n", "<leader>gs", function()
  neogit.open()
end, { desc = "Git status" })

map("n", "<leader><leader>gs", function()
  ts.git_stash()
end, { desc = "Git stash" })

map("n", "<leader>gd", function()
  vim.cmd([[DiffviewOpen]])
end, { desc = "Git diff" })

map("n", "<leader><leader>gd", function()
  vim.cmd([[DiffviewOpen origin/staging...HEAD]])
end, { desc = "Git diff - HEAD against staging" })

map("n", "<leader>gh", function()
  vim.cmd([[DiffviewFileHistory]])
end, { desc = "Git history" })

map("n", "<leader>gc", function()
  -- TODO: if no uncommited changes left then close
  neogit.open()
  neogit.open({ "commit" })
  vim.fn.feedkeys("c")
  -- TODO: then feedkeys feat: or test:
end, { desc = "Git commit" })

map("n", "<leader><leader>gc", function()
  diffview_actions.stage_all()
  vim.defer_fn(function()
    vim.cmd([[tabclose]])
    neogit.open()
    neogit.open({ "commit" })
    vim.fn.feedkeys("c")
  end, 100)
end, { desc = "Git stage all and commit" })

map("n", "<leader>gfh", function()
  vim.cmd([[DiffviewFileHistory %]])
end, { desc = "Git file - history" })

map("n", "<leader>gfx", function()
  vim.cmd([[Gitsigns reset_buffer]])
end, { desc = "Git file - discard changes" })

map("n", "<leader><leader>gfs", function()
  vim.cmd([[Gitsigns stage_buffer]])
end, { desc = "Git file - stage" })

map("n", "<leader>gb", function()
  ts.git_branches()
end, { desc = "Git branches" })

map("n", "<leader>gu", function()
  vim.cmd([[TermExec cmd="git reset --soft HEAD~1"]])
  vim.cmd([[ToggleTerm]])
end, { desc = "Git - undo last commit into working directory" })

map("n", "<leader><leader>gr", function()
  if vim.fn.confirm("", "Are you sure you'd like to discard ALL working changes? (&Yes\n&No)", 1) == 1 then
    vim.cmd([[TermExec cmd="git restore . && git clean -fd"]])
    vim.cmd([[ToggleTerm]])
  end
end, { desc = "Git - discard working changes" })

map("n", "<leader><leader>gb", function()
  require("git_blame").run()
end, { desc = "Git blame" })

map("n", "<leader>hj", function()
  vim.cmd([[Gitsigns next_hunk]])
  vim.fn.feedkeys("zz")
end, { desc = "Git hunk - next" })

map("n", "<leader>hk", function()
  vim.cmd([[Gitsigns prev_hunk]])
  vim.fn.feedkeys("zz")
end, { desc = "Git hunk - previous" })

map({ "n", "v" }, "<leader>hp", function()
  vim.cmd([[Gitsigns preview_hunk]])
end, { desc = "Git hunk - preview" })

map({ "n", "v" }, "<leader>hs", function()
  vim.cmd([[Gitsigns stage_hunk]])
end, { desc = "Git hunk - stage" })

map({ "n", "v" }, "<leader>hx", function()
  vim.cmd([[Gitsigns reset_hunk]])
end, { desc = "Git hunk - reset" })

map("n", "<leader>hu", function()
  vim.cmd([[Gitsigns undo_stage_hunk]])
end, { desc = "Git hunk - undo stage" })
