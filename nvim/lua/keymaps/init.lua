local function map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

vim.g.mapleader = ' '

map('i', 'kj', '<ESC>')

map('', 'H', '^')
map('', 'L', '$')

map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', 'K', 'i<Enter><Esc>')
map('n', 'Y', 'yy')
