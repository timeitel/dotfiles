local ts = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser
local themes = require("telescope.themes")
local notify_ext = require("telescope").extensions.notify
local map = require("tmtl.utils").map
local get_visual_selection = require("tmtl.utils").get_visual_selection

map("n", "<C-p>", function()
  ts.find_files({ hidden = true })
end, { desc = "Find - files" })

map("n", "<leader>ff", function()
  ts.live_grep({ initial_mode = "insert" })
end, { desc = "[F]ind in [F]iles - live grep" })

map("v", "<leader>ff", function()
  local text = get_visual_selection()
  ts.grep_string({ search = text })
end, { desc = "[F]ind in [F]iles - live grep selection" })

map("n", "<leader>ft", function()
  ts.grep_string({ search = "TODO" })
end, { desc = "[F]ind - [T]ODOs" })

map("n", "<leader>fb", function()
  ts.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[F]ind [B]uffers" })

map("n", "<leader>fk", function()
  ts.keymaps({ initial_mode = "insert" })
  vim.fn.feedkeys("<Space>")
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

map("n", "<leader>fn", function()
  notify_ext.notify(themes.get_dropdown({}))
end, { desc = "[F]ind - [N]otifications" })

map("n", "<leader>fd", function()
  ts.diagnostics(themes.get_dropdown({ path_display = "hidden" }))
end, { desc = "[F]ind - [D]iagnostics for workspace" })

map("n", "<leader>bp", function()
  fb.file_browser({ grouped = true, hidden = true })
end, { desc = "[B]rowse [P]roject" })

map("n", "<leader>bw", function()
  fb.file_browser({ grouped = true, cwd = vim.fn.expand("%:p:h"), hidden = true })
end, { desc = "[B]rowse buffer's [W]orking directory" })
