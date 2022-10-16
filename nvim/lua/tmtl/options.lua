local o = vim.opt

-- Ignore compiled files
o.wildignore = "__pycache__"
o.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
o.wildignore:append("Cargo.lock")

o.autoread = true
o.backspace = { "eol", "start", "indent" }
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
o.shortmess = o.shortmess + { c = true }
o.showcmd = true
o.showmatch = true
o.showmode = false
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.whichwrap = o.whichwrap + "<,>,h,l"

-- Tabs
o.autoindent = true
o.cindent = true
o.wrap = true

o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

o.breakindent = true
o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
o.linebreak = true

o.foldmethod = "marker"
o.foldlevel = 0
o.modelines = 1

o.belloff = "all"

o.joinspaces = false
o.fillchars = { eob = "~" }
o.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
o.undofile = true

-- Cursorline highlighting control
--  Only have it on in the active buffer
o.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
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
})

o.laststatus = 3
o.background = "dark"
o.termguicolors = true
o.signcolumn = "yes:1"

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false

-- TODO: fix
-- vim.api.nvim_command([[
-- au FileType * setlocal fo-=ato2 fo+=cqrnj
--     ]])
-- being overridden by ftplugin
o.formatoptions = o.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2"
