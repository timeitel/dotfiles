-- TODO: yank file name
-- TODO: C-O and C-I to go forward and back in file browser
local telescope = require("telescope")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local fb_actions = telescope.extensions.file_browser.actions

function table.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

-- Telescope defaults
local default_insert_mappings = {
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-h>"] = actions.close,
  ["<C-l>"] = actions.select_default + actions.center,
  ["<C-w>"] = function()
    vim.api.nvim_input("<c-s-w>")
  end,
  ["<C-s>"] = actions.select_horizontal,
  ["<M-p>"] = actions_layout.toggle_preview,
}

local default_normal_mappings = table.shallow_copy(default_insert_mappings)
default_normal_mappings["c"] = false
default_normal_mappings["l"] = actions.select_default + actions.center

-- Telescope File-browser
local file_browser_mappings = {
  ["<leader>."] = fb_actions.toggle_hidden,
  ["<leader>c"] = fb_actions.create,
  ["<leader>t"] = fb_actions.change_cwd,
  ["<leader>f"] = function()
    local entry = action_state.get_selected_entry()
    local filename = entry.Path.filename
    require("telescope.builtin").live_grep({ search_dirs = { filename }, results_title = filename })
  end,
  ["<leader>x"] = fb_actions.remove,
  ["h"] = fb_actions.goto_parent_dir,
  ["H"] = fb_actions.goto_cwd,
}

telescope.setup({
  defaults = {
    initial_mode = "normal",
    file_ignore_patterns = { ".DS_Store" },
    multi_icon = "<>",
    sorting_strategy = "ascending",
    path_display = { truncate = 2 },
    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "top",
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    mappings = {
      i = default_insert_mappings,
      n = default_normal_mappings,
    },
  },

  pickers = {
    buffers = {
      mappings = {
        n = {
          ["<leader>x"] = actions.delete_buffer,
        },
      },
    },
    git_stash = {
      mappings = {
        -- n = {
        --     ["d"] = function()
        --         local entry = action_state.get_selected_entry()
        --         -- local stash_idx = entry.value.find(entry, "%d+")
        --         -- print(vim.inspect(stash_idx))
        --     end,
        -- },
      },
    },
    git_commits = {
      mappings = {
        n = {
          ["<leader>yc"] = function()
            local entry = action_state.get_selected_entry()
            vim.fn.setreg("*", entry.value)
            print("Yanked hash:", entry.value)
          end,
          ["<leader>gd"] = function(prompt_bufnr)
            local current = action_state.get_selected_entry()
            actions.move_selection_next(prompt_bufnr)
            local previous = action_state.get_selected_entry()

            actions.close(prompt_bufnr)
            print(string.format("Opening diff of: %s, with its previous commit", current.value))
            vim.cmd(string.format("DiffviewOpen %s..%s", previous.value, current.value))
          end,
        },
      },
    },
    git_branches = {
      previewer = false,
      mappings = {
        n = {
          ["<leader>x"] = function(prompt_bufnr)
            actions.git_delete_branch(prompt_bufnr)
            require("telescope.builtin").git_branches()
          end,
        },
      },
    },
    find_files = { initial_mode = "insert" },
    live_grep = { initial_mode = "insert" },
    registers = {
      mappings = {
        n = {
          ["<leader>e"] = actions.edit_register,
        },
      },
    },
  },

  extensions = {
    file_browser = {
      mappings = {
        n = file_browser_mappings,
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
  },
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("possession")
