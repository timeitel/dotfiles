local map = Utils.map
local ts = require("telescope.builtin")

map("n", "<leader>gs", function()
    require("neogit").open()
end, { desc = "Git status" })

map("n", "<leader><leader>gs", function()
    ts.git_stash()
end, { desc = "Git stash" })

map("n", "<leader>gd", function()
    vim.cmd([[DiffviewOpen]])
end, { desc = "Git diff" })

map("n", "<leader>gh", function()
    ts.git_commits()
end, { desc = "Git history" })

map("n", "<leader><leader>gh", function()
    ts.git_bcommits()
end, { desc = "Git file history" })

map("n", "<leader>gc", function()
    vim.cmd("DiffviewClose")
    local neogit = require("neogit")
    neogit.open()
    neogit.open({ "commit" })
    vim.fn.feedkeys("c")
end, { desc = "Git commit" })

map("n", "<leader>gfx", function()
    vim.cmd([[Gitsigns reset_buffer]])
end, { desc = "Git file - discard changes" })

map("n", "<leader>gfs", function()
    vim.cmd([[Gitsigns stage_buffer]])
end, { desc = "Git file - stage" })

map("n", "<leader>gb", function()
    ts.git_branches()
end, { desc = "Git branches" })

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

map("n", "<leader>hp", function()
    vim.cmd([[Gitsigns preview_hunk]])
end, { desc = "Git hunk - preview" })

map({ "n", "v" }, "<leader>hs", function()
    vim.cmd([[Gitsigns stage_hunk]])
end, { desc = "Git hunk - stage" })

map("n", "<leader>hx", function()
    vim.cmd([[Gitsigns reset_hunk]])
end, { desc = "Git hunk - reset" })

map("n", "<leader>hu", function()
    vim.cmd([[Gitsigns undo_stage_hunk]])
end, { desc = "Git hunk - undo stage" })
