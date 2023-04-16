local gunmetal = "#282c34"
local M = {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				on_colors = function(colors)
					colors.bg = gunmetal
				end,
				on_highlights = function(hl, c)
					hl.CursorLine = {
						bg = "#363c58",
					}
					hl.DiffAdd = {
						bg = "#283c4e",
					}
					hl.DiffDelete = {
						bg = "#38222c",
					}
					hl.DiffChange = {
						bg = "#283c4e",
					}
					local float_normal = { bg = c.bg, fg = c.fg }
					hl.TelescopeNormal = float_normal
					hl.TelescopeBorder = float_normal
					hl.NormalFloat = float_normal
					hl.NavbuddyNormalFloat = float_normal
					hl.FloatBorder = float_normal
					hl.NavbuddyFloatBorder = float_normal
					hl.LspInfoBorder = float_normal
				end,
			})
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "tabs",
				buffer_close_icon = "",
				show_duplicate_prefix = false,
				max_name_length = 30,
				always_show_bufferline = false,
			},
		},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
}

return M
