local map = Utils.map
local harpoon_ui = require("harpoon.ui")

-- TODO: configure with c-h and c-l
map("n", "<leader>ea", function()
  require("harpoon.mark").add_file()
end, { desc = "Edit list - add" })

map("n", "<leader>el", function()
  harpoon_ui.toggle_quick_menu()
end, { desc = "Edit list - toggle menu" })

map("n", "<M-n>", function()
  harpoon_ui.nav_next()
end, { desc = "Edit list - next" })

map("n", "<M-p>", function()
  harpoon_ui.nav_prev()
end, { desc = "Edit list - previous" })

map("n", "<A-h>", function()
  harpoon_ui.nav_file(1)
end, { desc = "Edit list - file 1" })

map("n", "<A-j>", function()
  harpoon_ui.nav_file(2)
end, { desc = "Edit list - file 2" })

map("n", "<A-k>", function()
  harpoon_ui.nav_file(3)
end, { desc = "Edit list - file 3" })

map("n", "<A-l>", function()
  harpoon_ui.nav_file(4)
end, { desc = "Edit list - file 4" })
