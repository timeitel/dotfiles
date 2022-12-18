local ts = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser
local map = Utils.map
local getVisualSelection = Utils.getVisualSelection

map("n", "<C-p>", function()
  ts.find_files({ hidden = true })
end, { desc = "Find - files" })

-- TODO: fix not working
map("n", "<leader>/", function()
  ts.current_buffer_fuzzy_find()
end, { desc = "Find - current buffer" })

map("v", "<leader>/", function()
  local text = getVisualSelection()
  ts.current_buffer_fuzzy_find({ default_text = text })
end, { desc = "Find - current buffer" })

map("n", "<leader>ff", function()
  ts.live_grep({ initial_mode = "insert" })
end, { desc = "[F]ind in [F]iles - live grep" })

map("v", "<leader>ff", function()
  local text = getVisualSelection()
  ts.live_grep({ default_text = text })
end, { desc = "[F]ind in [F]iles - live grep selection" })

map("n", "<leader>ft", function()
  ts.grep_string({ search = "TODO" })
end, { desc = "[F]ind - [T]ODOs" })

map("n", "<leader>*", function()
  ts.grep_string()
end, { desc = "Find - word under cursor" })

map("v", "<leader>*", function()
  local text = getVisualSelection()
  ts.grep_string({ search = text })
end, { desc = "Find - word highlighted" })

map("n", "<leader>fb", function()
  ts.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[F]ind [B]uffers" })

map("n", "<leader>fc", function()
  ts.find_files({ cwd = "~/.dotfiles", hidden = true })
end, { desc = "[F]ind files in [C]onfig" })

map("n", "<leader>fk", function()
  ts.keymaps({ initial_mode = "insert" })
end, { desc = "[F]ind [K]eymaps" })

map("n", "<leader>fr", function()
  ts.resume({ initial_mode = "normal" })
end, { desc = "[F]ind - [R]esume last picker" })

map("n", "<leader><leader>fr", function()
  ts.registers()
end, { desc = "[F]ind [R]egisters" })

map("n", "<leader>fm", function()
  vim.cmd([[Telescope harpoon marks]])
end, { desc = "[F]ind - harpoon [M]arks" })

map("n", "<leader>bp", function()
  fb.file_browser({ grouped = true, hidden = true })
end, { desc = "[B]rowse [P]roject" })

map("n", "<leader>bw", function()
  fb.file_browser({ grouped = true, cwd = vim.fn.expand("%:p:h"), hidden = true })
end, { desc = "[B]rowse buffer's [W]orking directory" })

map("n", "<leader>bc", function()
  fb.file_browser({ grouped = true, cwd = "~/.dotfiles", hidden = true })
end, { desc = "[B]rowse [C]onfig" })
