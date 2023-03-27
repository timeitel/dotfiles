local o = vim.opt

o.autoindent = true
o.autoread = true
o.background = "dark"
o.backspace = { "eol", "start", "indent" }
o.belloff = "all"
o.breakindent = true
o.cindent = true
o.cmdheight = 0
o.completeopt = { "menu", "menuone", "noinsert" }
o.conceallevel = 3
o.cursorline = true
o.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal", "vertical" }
o.expandtab = true
o.fillchars = { eob = "~", diff = "╱" }
o.foldenable = false
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 0
o.foldmethod = "expr"
o.foldmethod = "marker"
o.history = 500
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
o.joinspaces = false
o.laststatus = 3
o.lazyredraw = true
o.modelines = 1
o.number = true
o.relativenumber = true
o.scrollbind = false
o.scrolloff = 10
o.sessionoptions = o.sessionoptions - "buffers"
o.shiftwidth = 2
o.shortmess:append("c")
o.showbreak = string.rep(" ", 3) -- smart line wrapping
o.showcmd = true
o.showmatch = true
o.showmode = false
o.signcolumn = "yes:1"
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.whichwrap:append("<,>,h,l")
o.shortmess:append("c")

-- Tabs
o.autoindent = true
o.cindent = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
o.wrap = true

o.breakindent = true
o.showbreak = string.rep(" ", 3) -- smart line wrapping
o.linebreak = true

o.belloff = "all"

o.joinspaces = false
o.fillchars = { eob = "~", diff = "╱" }
o.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal", "vertical" }
o.undofile = true
o.whichwrap:append("<,>,h,l")
o.wildignore = "__pycache__"
o.wildignore:append("Cargo.lock")
o.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
o.wrap = true

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

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-o>"'))
    vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-o>"'))
  end,
  desc = "Open to most recent file",
  group = group,
})

o.laststatus = 3
o.background = "dark"
o.termguicolors = true
o.signcolumn = "yes:1"

o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = true
o.foldlevelstart = 99

vim.api.nvim_command([[
au FileType * set fo=cqrnj
    ]])

-- pipe tsc errors into qf list
-- TODO: look into nvim -q <(flake8 .)
-- passing tsc lint output into qf list

vim.cmd([[
  augroup tsc
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=tsc
  augroup END
]])
