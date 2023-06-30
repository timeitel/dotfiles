local o = vim.opt

o.autoread = true
o.background = "dark"
o.backspace = { "eol", "start", "indent" }
o.belloff = "all"
o.breakindent = true
o.cmdheight = 0
o.completeopt = { "menu", "menuone", "noinsert" }
o.conceallevel = 0
o.cursorline = true
o.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal", "vertical" }
o.fillchars = { eob = "~", diff = "╱" }
o.history = 500
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
o.signcolumn = "yes:1"
o.laststatus = 3
o.lazyredraw = true
o.modelines = 1
o.number = true
o.relativenumber = true
o.scrollbind = false
o.scrolloff = 10
o.sessionoptions = o.sessionoptions - "buffers"
o.showcmd = true
o.showmatch = true
o.showmode = false
o.signcolumn = "yes:1"
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.termguicolors = true
o.undofile = true
o.whichwrap:append("<,>,h,l")
o.wildignore = "__pycache__"
o.wildignore:append("Cargo.lock")
o.wildignore:append({ "*.o", "*.pyc", "*pycache*", "*~" })
o.wrap = false

-- Tabs
o.autoindent = true
o.cindent = true
o.expandtab = true -- `:retab` if any tab diff issues
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

-- cmdheight = 0
o.shortmess:append("C")
o.shortmess:append("S") -- already have lualine search counter
o.shortmess:append("c")
o.shortmess:append("s")
o.shortmess:append("I")

-- folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = true
o.foldlevelstart = 99

-- list chars
o.list = true
o.listchars = ""
o.listchars:append({ extends = "#" })
o.listchars:append({ tab = ">-" })
o.listchars:append({ lead = "·" })
o.listchars:append({ extends = "»" })
o.listchars:append({ precedes = "«" })
o.listchars:append({ nbsp = "⣿" })

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
    vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-w>="'))
  end,
  desc = "Resize windows on terminal resize",
  group = group,
})

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
