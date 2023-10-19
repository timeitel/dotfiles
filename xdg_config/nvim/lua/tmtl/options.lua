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
o.showtabline = 0
o.signcolumn = "yes:1"
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.termguicolors = true
o.undofile = true
o.whichwrap:append("<,>,h,l")
o.wildignore:append({ "__pycache__", "*.o", "*.pyc", "*pycache*", "*~", "Cargo.lock" })
o.wrap = false

-- Tabs
o.autoindent = true
o.cindent = true
o.expandtab = true -- `:retab` if any tab diff issues
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2

o.shortmess:append("C")
o.shortmess:append("I")
o.shortmess:append("S") -- already have lualine search counter
o.shortmess:append("c")
o.shortmess:append("s")

-- folding
o.foldenable = true
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 99
o.foldmethod = "expr"

-- list chars
o.list = true
o.listchars = ""
o.listchars:append({ extends = "»" })
o.listchars:append({ leadmultispace = "┊ " })
o.listchars:append({ lead = "·" })
o.listchars:append({ nbsp = "⣿" })
o.listchars:append({ precedes = "«" })
o.listchars:append({ tab = ">-" })
