local group = vim.api.nvim_create_augroup("Options", { clear = true })

local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank({ timeout = 200 })
  end,
  desc = "Highlight yank",
  group = group,
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd([[wincmd =]])
  end,
  desc = "Resize windows on terminal resize",
  group = group,
})

-- TODO: saving file removes mark?
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = { "*.lua", "*.rs", "*.go", "*.ts", "*.tsx", "*.js", "*.json", "*.toml", "*.yaml", "*.yml" },
  command = "normal! mI",
  desc = "Update global last insert mark",
  group = group,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "dap-float", "dap-repl", "notify", "qf", "toggleterm" },
  callback = function()
    local map = require("tmtl.utils").map
    map("n", "q", function()
      vim.cmd([[close]])
    end, { desc = "Close window", buffer = true })
  end,
  desc = "Close window",
  group = group,
})

vim.api.nvim_create_autocmd("WinNew", { command = "wincmd L" })

-- Comments
vim.api.nvim_command([[
au FileType * set fo=cqrnj
    ]])

-- Disable treesitter in command window
vim.api.nvim_create_augroup("_cmd_win", { clear = true })
vim.api.nvim_create_autocmd("CmdWinEnter", {
  callback = function()
    vim.keymap.del("n", "<CR>", { buffer = true })
  end,
  group = "_cmd_win",
})
