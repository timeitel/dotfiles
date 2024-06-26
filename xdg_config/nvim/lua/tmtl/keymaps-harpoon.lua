local map = require("tmtl.utils").map
local harpoon_ui = require("harpoon.ui")

map("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "[E]dit List - [A]dd" })

map("n", "<leader>e", function()
  harpoon_ui.toggle_quick_menu()
end, { desc = "[E]dit [L]ist - toggle" })

map("n", "]f", function()
  harpoon_ui.nav_next()
end, { desc = "[E]dit List - next [F]ile" })

map("n", "[f", function()
  harpoon_ui.nav_prev()
end, { desc = "[E]dit List - previous [F]ile" })

map("n", "<A-h>", function()
  harpoon_ui.nav_file(1)
end, { desc = "[E]dit List - file 1" })

map("n", "<A-j>", function()
  harpoon_ui.nav_file(2)
end, { desc = "[E]dit List - file 2" })

map("n", "<A-k>", function()
  harpoon_ui.nav_file(3)
end, { desc = "[E]dit List - file 3" })

map("n", "<A-l>", function()
  harpoon_ui.nav_file(4)
end, { desc = "[E]dit List - file 4" })

map("n", "<A-;>", function()
  harpoon_ui.nav_file(5)
end, { desc = "[E]dit List - file 5" })
