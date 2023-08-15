vim.g.netrw_banner = 0
vim.g.netrw_list_hide = ".*\\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\\.\\.\\=/\\=$"
local autocmd = vim.api.nvim_create_autocmd

-- local options_append = {
--   netrw_banner = 0, -- hide banner
--   netrw_localmkdir = "mkdir -p", -- change mkdir cmd
--   netrw_localcopycmd = "cp -r", -- change copy command
--   netrw_localrmdir = "rm -r", -- change delete command
--   netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']],
-- }
-- for k, v in pairs(options_append) do
--   g[k] = v
-- end

autocmd("filetype", {
  pattern = "netrw",
  desc = "Better mappings for netrw",
  callback = function()
    local map = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
    end

    -- Navigation
    map("h", "-^") -- go up
    map("l", "<CR>") -- open file or dir
    map(".", "gh") -- toggle dotfiles
    map("s", function()
      require("leap").leap({ opts = { labels = {} } })
    end) -- toggle dotfiles
    map("S", function()
      require("leap").leap({ backward = true })
    end) -- toggle dotfiles
    map("H", ":e .<CR>") -- home / cwd
    map("t", ":cd %<CR>") -- set cwd to current folder
  end,
})
