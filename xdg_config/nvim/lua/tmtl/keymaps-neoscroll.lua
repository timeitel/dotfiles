local mappings = {}
mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "1" } }
mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "1" } }
require("neoscroll.config").set_mappings(mappings)
