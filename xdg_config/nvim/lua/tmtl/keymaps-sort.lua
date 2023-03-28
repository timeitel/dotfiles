local map = require("tmtl.utils").map

map("v", "go", "<Esc><Cmd>Sort<CR>", { desc = "Sort visual selection" })
map("n", "go", "vi{<Esc><Cmd>Sort<CR>", { desc = "Sort inside curly brace" })

-- nnoremap <silent> go" vi"<Esc><Cmd>Sort<CR>
-- nnoremap <silent> go' vi'<Esc><Cmd>Sort<CR>
-- nnoremap <silent> go( vi(<Esc><Cmd>Sort<CR>
-- nnoremap <silent> go[ vi[<Esc><Cmd>Sort<CR>
-- nnoremap <silent> gop vip<Esc><Cmd>Sort<CR>
-- nnoremap <silent> go{ vi{<Esc><Cmd>Sort<CR>
