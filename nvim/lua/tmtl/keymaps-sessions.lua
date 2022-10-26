local map = Utils.map

map("n", "<leader>fs", function()
    require("telescope").extensions.possession.list()
end, { desc = "List sessions" })

map("n", "<leader>sl", function()
    vim.cmd([[SLoad]])
end, { desc = "Load last session" })

map("n", "<leader>sd", function()
    vim.cmd([[SDelete]])
end, { desc = "Delete current session" })
