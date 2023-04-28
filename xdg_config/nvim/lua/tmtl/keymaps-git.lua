local map = require("tmtl.utils").map
local request_confirm = require("tmtl.utils").request_confirm
local ts = require("telescope.builtin")
local diffview_actions = require("diffview.actions")
local neogit = require("neogit")
local notify = require("notify")

function Open_Git_Commit()
  neogit.open()
  neogit.open({ "commit" })
  vim.fn.feedkeys("c")
end

map("n", "<leader>gs", function()
  neogit.open()
end, { desc = "[G]it [S]tatus" })

map("n", "<leader><leader>gs", function()
  ts.git_stash()
end, { desc = "[[G]]it [S]tash" })

map("n", "<leader>gd", function()
  vim.cmd([[DiffviewOpen]])
end, { desc = "[G]it [D]iff" })

map("n", "<leader><leader>gd", function()
  -- TODO: fetch origin first
  vim.cmd([[DiffviewOpen origin/dev...HEAD]])
  notify('Opening diff: "origin/dev...HEAD"')
end, { desc = "[[G]]it [D]iff - HEAD against staging" })

map("n", "<leader>gh", function()
  vim.cmd([[DiffviewFileHistory]])
end, { desc = "[G]it [H]istory" })

map("n", "<leader>gc", Open_Git_Commit, { desc = "[G]it [C]ommit" })

map("n", "<leader><leader>gc", function()
  -- TODO: fix / do
  diffview_actions.stage_all()
  vim.defer_fn(function()
    vim.cmd([[tabclose]])
    neogit.open()
    neogit.open({ "commit" })
    vim.fn.feedkeys("c")
  end, 100)
  notify("Staging all changes")
end, { desc = "[[G]]it [C]ommit - stage all and commit" })

map("n", "<leader>gfh", function()
  vim.cmd([[DiffviewFileHistory %]])
end, { desc = "[G]it [F]ile [H]istory" })

map("n", "<leader>gfx", function()
  vim.cmd([[Gitsigns reset_buffer]])
  notify("Discarded changes of current file", vim.log.levels.WARN)
end, { desc = "[G]it [F]ile - discard changes" })

map("n", "<leader><leader>gfs", function()
  vim.cmd([[Gitsigns stage_buffer]])
  notify("Staged current file")
end, { desc = "[[G]]it [F]ile [S]tage" })

map("n", "<leader>gb", function()
  ts.git_branches()
end, { desc = "[G]it [B]ranches" })

map("n", "<leader>gu", function()
  vim.cmd([[TermExec cmd="git reset --soft HEAD~1"]])
end, { desc = "[G]it [U]ndo - last commit into working directory" })

map("n", "<leader>gx", function()
  request_confirm({ prompt = "discard ALL working changes", on_confirm = function()
    require('toggleterm').exec_command('cmd="git restore . && git clean -fd" open=0')
    notify("Discarded ALL working changes", vim.log.levels.WARN)
  end })
end, { desc = "[[G]]it [R]eset - discard ALL working changes" })

map("n", "<leader><leader>gb", function()
  require("git_blame").run()
end, { desc = "[G]it [B]lame" })

map("n", "<C-j>", function()
  vim.cmd([[Gitsigns next_hunk]])
  vim.defer_fn(function()
    vim.fn.feedkeys("zz")
  end, 10)
end, { desc = "Git [H]unk - next" })

map("n", "<C-k>", function()
  vim.cmd([[Gitsigns prev_hunk]])
  vim.defer_fn(function()
    vim.fn.feedkeys("zz")
  end, 10)
end, { desc = "Git [H]unk - previous" })

map({ "n", "v" }, "<leader>hp", function()
  vim.cmd([[Gitsigns preview_hunk]])
end, { desc = "Git [H]unk [P]review" })

map({ "n", "v" }, "<leader>hs", function()
  vim.cmd([[Gitsigns stage_hunk]])
  notify("Staged hunk")
end, { desc = "Git [H]unk [S]tage" })

map({ "n", "v" }, "<leader>hx", function()
  vim.cmd([[Gitsigns reset_hunk]])
  notify("Discarded hunk", vim.log.levels.WARN)
end, { desc = "Git [H]unk - reset" })

map("n", "<leader>hu", function()
  vim.cmd([[Gitsigns undo_stage_hunk]])
  notify("Unstaged the last staged hunk")
end, { desc = "Git [H]unk [U]ndo - last staged hunk" })
