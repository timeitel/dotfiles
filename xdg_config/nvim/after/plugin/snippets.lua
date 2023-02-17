local ls = require("luasnip")
local snippet = ls.snippet
local f = ls.function_node
local text = ls.text_node
local insert = ls.insert_node
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

local get_filename = function()
  return f(function(_, snip)
    local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
    return name[1] or ""
  end)
end

ls.add_snippets(nil, {
  all = {
    snippet({
      trig = "fc",
      namr = "Functional component",
      dscr = "React functional component",
    }, {
      text("export const "),
      get_filename(),
      insert(1),
      text({ " : FC = () => {" }),
      text({ "return (" }),
      text({ "<>" }),
      insert(2),
      text({ "</>" }),
      text({ ");" }),
      text({ "};" }),
    }),
    snippet({
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
    snippet({
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
    snippet({
      trig = "clg",
      namr = "Console log",
      dscr = "JS console log",
    }, {
      text("console.log("),
      insert(1),
      text(")"),
    }),
    snippet({
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
    snippet({
      trig = "int",
      namr = "Interface",
      dscr = "TypeScript interface",
    }, {
      text("interface "),
      insert(1, "Props"),
      text({ " {", '' }),
      text("    "),
      insert(2),
      text({ "", "}"}),
    }),
  },
})
