local ts = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser
local map = Utils.map
local getVisualSelection = Utils.getVisualSelection

map("n", "<C-p>", function()
    ts.find_files()
end, { desc = "Find - files" })

map("n", "<leader>/", function()
    ts.current_buffer_fuzzy_find()
end, { desc = "Find - current buffer" })

map("v", "<leader>/", function()
    local text = getVisualSelection()
    ts.current_buffer_fuzzy_find({ default_text = text })
end, { desc = "Find - current buffer" })

map("n", "<leader>ff", function()
    ts.live_grep()
end, { desc = "Find - in files" })

map("v", "<leader>ff", function()
    local text = getVisualSelection()
    ts.live_grep({ default_text = text })
end, { desc = "Find - in files" })

map("n", "<leader>fb", function()
    ts.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "Find - buffers" })

map("n", "<leader>fc", function()
    ts.find_files({ cwd = "~/.dotfiles" })
end, { desc = "Find - files in config" })

map("n", "<leader>fw", function()
    ts.find_files({ cwd = "vim.fn.expand('%:p:h')" })
end, { desc = "Find - files in buffer's wd" })

map("n", "<leader>fk", function()
    ts.keymaps()
end, { desc = "Find - keymaps" })

map("n", "<leader>fr", function()
    ts.resume()
end, { desc = "Find - resume last picker" })

map("n", "<leader><leader>fr", function()
    ts.registers()
end, { desc = "Find - registers" })

map("n", "<leader>fm", function()
    vim.cmd([[Telescope harpoon marks]])
end, { desc = "Find - harpoon marks" })

map("n", "<leader>bp", function()
    fb.file_browser({ grouped = true })
end, { desc = "Browse - project" })

map("n", "<leader>bw", function()
    fb.file_browser({ grouped = true, cwd = vim.fn.expand("%:p:h") })
end, { desc = "Browse - buffer's wd" })

map("n", "<leader>bc", function()
    fb.file_browser({ grouped = true, cwd = "~/.dotfiles" })
end, { desc = "Browse - config" })
