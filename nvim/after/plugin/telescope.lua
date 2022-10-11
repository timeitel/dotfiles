local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".DS_Store" },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        multi_icon = "<>",
        winblend = 0,
        layout_strategy = "horizontal",
        wrap_results = true,
        path_display = { truncate = 2 },
        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",
            horizontal = {
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },
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

        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        color_devicons = true,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = actions.close,
                ["<C-l>"] = actions.select_default + actions.center,
                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
                ["<C-s>"] = actions.select_horizontal,
                ["<M-p>"] = actions_layout.toggle_preview,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = actions.close,
                ["<C-l>"] = actions.select_default + actions.center,
                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
                ["<C-s>"] = actions.select_horizontal,
                ["<M-p>"] = actions_layout.toggle_preview,
            },
        },
    },

    pickers = {
        buffers = {
            mappings = {
                n = {
                    ["d"] = require("telescope.actions").delete_buffer,
                },
            },
        },
        git_stash = {}, -- TODO: delete either stash or branch
        git_branches = {},
    },

    extensions = {
        file_browser = {
            hijack_netrw = true,
            mappings = {
                i = {
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["<C-.>"] = fb_actions.toggle_hidden,
                },
                n = {
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["<C-.>"] = fb_actions.toggle_hidden,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["H"] = fb_actions.goto_cwd,
                    ["l"] = actions.select_default + actions.center,
                    ["F"] = function(one, two)
                        print(vim.inspect(one), vim.inspect(two))
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
