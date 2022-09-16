local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		multi_icon = "<>",
		-- path_display = "truncate",
		path_display={"smart"},
		winblend = 0,
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.85,
			-- preview_cutoff = 120,
			prompt_position = "bottom",
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

		pickers = {
			find_files = {
				hidden = true,
			},
		},

		selection_strategy = "reset",
		sorting_strategy = "descending",
		scroll_strategy = "cycle",
		color_devicons = true,

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-e>"] = actions.close,
				["<C-y>"] = actions.select_default + actions.center,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-e>"] = actions.close,
				["<C-y>"] = actions.select_default + actions.center,
			},
		},
		extensions = {
			file_browser = {},
		},
	},
})

require("telescope").load_extension("file_browser")
