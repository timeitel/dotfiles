vim.fn.feedkeys("i")

local commit_number = 0

local function paste_commit_message()
  vim.api.nvim_input("<C-o>cc")
  vim.schedule(function()
    local result = vim.fn.systemlist("git log -1 --pretty=%B HEAD~" .. commit_number)
    vim.fn.feedkeys(result[1])
  end)
end

vim.keymap.set("n", "q", "<CMD>close!<CR>", { desc = "Close status buffer", buffer = true })

vim.keymap.set("i", "<M-p>", function()
  paste_commit_message()
  commit_number = commit_number + 1
end, { desc = "Get previous commit message", buffer = true })

vim.keymap.set("i", "<M-n>", function()
  paste_commit_message()

  if commit_number > 0 then
    commit_number = commit_number - 1
  end
end, { desc = "Get next commit message", buffer = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  buffer = 0,
  callback = function()
    vim.schedule(function()
      vim.cmd("DiffviewClose")
    end)
  end,
})
