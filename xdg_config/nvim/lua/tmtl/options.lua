local o = vim.opt

-- Ignore compiled files
o.wildignore = "__pycache__"
o.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
o.wildignore:append("Cargo.lock")

o.autoread = true
o.backspace = { "eol", "start", "indent" }
o.belloff = "all"
o.breakindent = true
o.cindent = true
o.cmdheight = 1
o.completeopt = { "menu", "menuone", "noinsert" }
o.history = 500
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
o.lazyredraw = true
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.showcmd = true
o.showmatch = true
o.showmode = false
o.smartcase = true
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

local group = vim.api.nvim_create_augroup("Options", { clear = true })

o.cursorline = true -- Highlight the current line

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

o.scrollbind = false
o.sessionoptions = o.sessionoptions - "buffers"

-- pipe tsc errors into qf list
-- TODO: look into nvim -q <(flake8 .)
-- passing tsc lint output into qf list

vim.cmd([[
  augroup tsc
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=tsc
  augroup END
]])
