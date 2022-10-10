local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "meta",
            namr = "Metadata",
            dscr = "Yaml metadata format for markdown",
        }, {
            text({ "---", "title: " }),
            insert(1, "note_title"),
            text({ "", "author: " }),
            insert(2, "author"),
            text({ "", "date: " }),
            text({ "", "categories: [" }),
            insert(3, ""),
            text({ "]", "lastmod: " }),
            text({ "", "tags: [" }),
            insert(4),
            text({ "]", "comments: true", "---", "" }),
            insert(0),
        }),
    },
})
