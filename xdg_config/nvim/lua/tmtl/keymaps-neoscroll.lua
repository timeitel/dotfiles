local mappings = {}
mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "30" } }
mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "30" } }
require("neoscroll.config").set_mappings(mappings)
