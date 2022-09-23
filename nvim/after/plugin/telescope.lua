local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
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
            -- preview_cutoff = 120,
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
                ["<C-e>"] = actions.close,
                ["<C-y>"] = actions.select_default + actions.center,
                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
                ["<C-s>"] = actions.select_horizontal,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-e>"] = actions.close,
                ["<C-y>"] = actions.select_default + actions.center,
                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
                ["<C-s>"] = actions.select_horizontal,
            },
        },

        pickers = {
        },

        extensions = {
            file_browser = {
                hijack_netrw = true,
                mappings = {
                    i = {
                        ['<C-y>'] = actions.select_default
                    },
                },
            },
        },
    }
})

require("telescope").load_extension("file_browser")