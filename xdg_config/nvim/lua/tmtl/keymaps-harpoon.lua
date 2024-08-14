local map = require("tmtl.utils").map
local harpoon = require("harpoon")

map("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "[E]dit List - [A]dd" })

map("n", "<leader>e", function()
  harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" })
end, { desc = "[E]dit [L]ist - toggle" })

map("n", "]f", function()
  harpoon:list():next()
end, { desc = "[E]dit List - next [F]ile" })

map("n", "[f", function()
  harpoon:list():prev()
end, { desc = "[E]dit List - previous [F]ile" })

map("n", "<A-h>", function()
  harpoon:list():select(1)
end, { desc = "[E]dit List - file 1" })

map("n", "<A-j>", function()
  harpoon:list():select(2)
end, { desc = "[E]dit List - file 2" })

map("n", "<A-k>", function()
  harpoon:list():select(3)
end, { desc = "[E]dit List - file 3" })

map("n", "<A-l>", function()
  harpoon:list():select(4)
end, { desc = "[E]dit List - file 4" })

map("n", "<A-;>", function()
  harpoon:list():select(5)
end, { desc = "[E]dit List - file 5" })
