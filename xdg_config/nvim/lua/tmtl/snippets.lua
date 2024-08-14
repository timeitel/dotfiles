local map = require("tmtl.utils").map
local ls = require("luasnip")
local snippet = ls.snippet
local f = ls.function_node
local text = ls.text_node
local insert = ls.insert_node

map({ "i", "s" }, "<C-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", { desc = "Snippet - jump forwards" })
map({ "i", "s" }, "<C-p>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { desc = "Snippet - jump backwards" })

local get_filename = function()
  return f(function(_, snip)
    local name = vim.split(snip.snippet.env.TM_FILENAME, ".")
    return name[1] or ""
  end)
end

local js_snips = {
  snippet("fn", {
    text("function "),
    insert(1, "name"),
    text({ "(" }),
    insert(2),
    text({ ") {" }),
    insert(3),
    text({ "};" }),
  }),
  snippet({
    trig = "fc",
    namr = "Functional component",
    dscr = "React functional component",
  }, {
    text("export default function "),
    get_filename(),
    insert(1),
    text({ "() {" }),
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
  snippet("clg", {
    text("console.log("),
    insert(1),
    text(")"),
  }),
  snippet("int", {
    text("interface "),
    insert(1, "Props"),
    text({ " {", "" }),
    text("    "),
    insert(2),
    text({ "", "}" }),
  }),
}

ls.add_snippets(nil, {
  javascript = js_snips,
  typescript = js_snips,
  typescriptreact = js_snips,
  go = {
    snippet("fn", {
      text("func "),
      insert(1),
      text(" "),
      insert(2, "funcName"),
      text({ "(" }),
      insert(3),
      text(") "),
      insert(4),
      text({ " {", "	" }),
      insert(5),
      text({ "", "};" }),
    }),
    snippet("int", {
      text("type "),
      insert(1, "Interface"),
      text({ " interface {", "" }),
      text("	"),
      insert(2, ""),
      text({ "", "}" }),
    }),
    snippet("err", {
      text({ "if err != nil {", "" }),
      text({ "	log.Fatal(err)", "" }),
      text({ "}", "" }),
    }),
  },
})
