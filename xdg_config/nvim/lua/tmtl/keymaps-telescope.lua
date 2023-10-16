local ts = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser
local themes = require("telescope.themes")
local notify_ext = require("telescope").extensions.notify
local map = require("tmtl.utils").map
local get_visual_selection = require("tmtl.utils").get_visual_selection

map("n", "<C-p>", function()
  require('tmtl.telescope-pickers').prettyFilesPicker({ picker = 'find_files', options = { hidden = true } })
end, { desc = "Find - files" })

map("n", "<leader>ff", function()
  require('tmtl.telescope-pickers').prettyGrepPicker({ picker = 'live_grep', options = { initial_mode = "insert" } })
end, { desc = "[F]ind [F]iles: live grep" })

map("v", "<leader>ff", function()
  local text = get_visual_selection()
  require('tmtl.telescope-pickers').prettyGrepPicker({ picker = 'grep_string', options = { search = text } })
end, { desc = "[F]ind [F]iles: live grep selection" })

map("n", "<leader>fa", function()
  require('tmtl.telescope-pickers').prettyFilesPicker({ picker = 'find_files',
    options = { no_ignore = true, hidden = true } })
end, { desc = "[F]ind [A]ll: incl hidden and gitignore" })

map("n", "<leader>ft", function()
  require('tmtl.telescope-pickers').prettyGrepPicker({ picker = 'grep_string', options = { search = "TODO" } })
end, { desc = "[F]ind [T]ODOs" })

map("n", "<leader>fb", function()
  require('tmtl.telescope-pickers').prettyBuffersPicker({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[F]ind [B]uffers" })

map("n", "<leader>fs", function()
  require('tmtl.telescope-pickers').prettyDocumentSymbols({ initial_mode = "insert" })
end, { desc = "[F]ind [S]ymbols" })

map("n", "<leader>fw", function()
  require('tmtl.telescope-pickers').prettyWorkspaceSymbols({ initial_mode = "insert" })
end, { desc = "[F]ind [W]orkspace symbols" })

map("n", "<leader>fk", function()
  ts.keymaps({ initial_mode = "insert" })
  vim.fn.feedkeys("<Space>")
end, { desc = "[F]ind [K]eymaps" })

map("n", "<leader>fr", function()
  ts.resume({ initial_mode = "normal" })
end, { desc = "[F]ind [R]esume: last picker" })

map("n", "<leader><leader>fr", function()
  ts.registers()
end, { desc = "[F]ind [R]egisters" })

map("n", "<leader>fm", function()
  vim.cmd([[Telescope harpoon marks]])
end, { desc = "[F]ind [M]arks: harpoon" })

map("n", "<leader>fn", function()
  notify_ext.notify(themes.get_dropdown({}))
end, { desc = "[F]ind [N]otifications" })

map("n", "<leader>fd", function()
  ts.diagnostics(themes.get_dropdown({ path_display = "hidden" }))
end, { desc = "[F]ind [D]iagnostics for workspace" })

map("n", "<leader>bp", function()
  fb.file_browser()
end, { desc = "[B]rowse [P]roject" })

map("n", "<leader>bw", function()
  fb.file_browser({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "[B]rowse [W]orking directory of buffer" })

map("n", "<leader>fu", function()
  require("telescope").extensions.undo.undo()
end, { desc = "[F]ind [U]ndo history" })

-- TODO: fix
-- map("n", "<leader>fgw", function()
--   require('telescope').extensions.git_worktree.git_worktrees()
-- end, { desc = "[F]ind [W]orktrees" })

map("n", "<leader>fc", function()
  ts.commands({ initial_mode = "insert" })
end, { desc = "[F]ind [C]ommands" })
