local telescope = require("telescope")
local action_state = require("telescope.actions.state")
local action_util = require("telescope.actions.utils")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local fb_actions = telescope.extensions.file_browser.actions
-- TODO: show current open file highlighted

function table.shallow_copy(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

local default_insert_mappings = {
    ["c"] = false,
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

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".DS_Store" },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
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
            initial_mode = "normal",
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,
                },
                n = {
                    ["<C-d>"] = actions.delete_buffer,
                },
            },
        },
        git_stash = {
            initial_mode = "normal",
        },
        git_branches = {
            previewer = false,
            initial_mode = "normal",
            mappings = {
                i = {
                    ["<C-d>"] = function(opts)
                        actions.git_delete_branch(opts)
                        require("telescope.builtin").git_branches()
                    end,
                },
                n = {
                    ["<C-d>"] = function(opts)
                        actions.git_delete_branch(opts)
                        require("telescope.builtin").git_branches()
                    end,
                },
            },
        },
        lsp_references = {
            initial_mode = "normal",
        },
    },

    extensions = {
        file_browser = {
            initial_mode = "normal",
            hijack_netrw = true,
            mappings = {
                i = {
                    ["<C-.>"] = fb_actions.toggle_hidden,
                    ["<C-c>"] = fb_actions.create,
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["<C-f>"] = function() --TODO: find in files of folder
                        local entry = action_state.get_selected_entry()
                        local filename = entry.Path.filename
                        require("telescope.builtin").live_grep({ search_dirs = { filename }, results_title = filename })
                    end,
                },
                n = {
                    ["<C-.>"] = fb_actions.toggle_hidden,
                    ["<C-c>"] = fb_actions.create,
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["H"] = fb_actions.goto_cwd,
                    ["<C-f>"] = function() --TODO: find in files of folder
                        local entry = action_state.get_selected_entry()
                        local filename = entry.Path.filename
                        require("telescope.builtin").live_grep({ search_dirs = { filename }, results_title = filename })
                    end,
                },
            },
        },
        ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
        },
    },
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
