local ls = require("luasnip")
local s = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

ls.add_snippets(nil, {
    all = {
        s({
            trig = "fc",
            namr = "Functional component",
            dscr = "React functional component",
        }, {
            text("export const "),
            insert(1, "Component"),
            text({ " : FC = () => {" }),
            text({ "return (" }),
            text({ "<>" }),
            insert(2),
            text({ "</>" }),
            text({ ");" }),
            text({ "};" }),
        }),
        s({
            trig = "dar",
            namr = "Destructured array",
            dscr = "JS destructured array",
        }, {
            text("const ["),
            insert(1, "state"),
            text(",  set"),
            insert(2, "State"),
            text("] = "),
            insert(3, "Object"),
        }),
        s({
            trig = "dob",
            namr = "Destructured object",
            dscr = "JS destructured object",
        }, {
            text("const {"),
            insert(2),
            text("}"),
            text(" = "),
            insert(1, "Object"),
        }),
        s({
            trig = "clg",
            namr = "Console log",
            dscr = "JS console log",
        }, {
            text("console.log("),
            insert(1),
            text(")"),
        }),
        s({
            trig = "nfn",
            namr = "Named function",
            dscr = "JS named function",
        }, {
            text("const "),
            insert(1, "name"),
            text(" = ("),
            insert(2, "arg"),
            text(") => {"),
            insert(3),
            text("}"),
        }),
    },
})
