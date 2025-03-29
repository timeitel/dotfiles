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
    require("vim.hl").on_yank({ timeout = 150 })
  end,
  desc = "Highlight yank",
  group = group,
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd.wincmd("=")
  end,
  desc = "Resize windows on terminal resize",
  group = group,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "TelescopePrompt" },
  callback = function()
    vim.keymap.set("i", "<C-c>", "<CMD>close!<CR>", { desc = "Close window", buffer = 0 })
  end,
  desc = "Close window",
  group = group,
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
  group = group,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})
