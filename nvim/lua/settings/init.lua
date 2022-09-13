local o = vim.opt

o.relativenumber=true
o.history=500
o.autoread=true
o.cmdheight=1
-- o.nohlsearch=true
o.backspace=eol,start,indent
-- o.whichwrap+=<,>,h,l
o.ignorecase=true
o.smartcase=true
o.incsearch=true
o.lazyredraw=true
o.showmatch=true
-- o.noerrorbells=true
-- o.novisualbell=true
-- o.t_vb=
-- o.tm=500
-- o.foldcolumn=1
-- o.nobackup=true
-- o.nowb=true
-- o.noswapfile=true
-- o.expandtab=true
-- o.scrolloff=8
-- o.shiftwidth=4
-- o.tabstop=4
-- o.lbr=true
-- o.tw=500
-- o.ai
-- o.si
-- o.laststatus=2
-- o.colorcolumn=80

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() require'vim.highlight'.on_yank({timeout = 200}) end,
    desc = "Highlight yank",
})
