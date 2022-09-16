local o = vim.opt

o.relativenumber = true
o.history = 500
o.autoread = true
o.cmdheight = 1
o.hlsearch = false
o.backspace = eol, start, indent
o.whichwrap = o.whichwrap + "<,>,h,l"
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.lazyredraw = true
o.showmatch = true
o.expandtab = true
o.scrolloff = 8
o.shiftwidth = 4
o.tabstop = 4
o.laststatus = 2
o.completeopt = { "menu", "menuone" }
o.shortmess = vim.opt.shortmess + { c = true }

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ timeout = 200 })
	end,
	desc = "Highlight yank",
})
