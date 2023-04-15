local M = {
	"RishabhRD/popfix",
	"ThePrimeagen/harpoon",
	"bkad/CamelCaseMotion",
	"inkarkat/vim-ReplaceWithRegister",
	"rcarriga/nvim-notify",
	"tpope/vim-commentary",
	{
		"sQVe/sort.nvim",
		config = function()
			local map = require("tmtl.utils").map
			map("v", "go", "<Esc><Cmd>Sort<CR>", { desc = "Sort visual selection" })
			map("n", "go", "vi{<Esc><Cmd>Sort<CR>", { desc = "Sort inside curly brace" })
		end,
	},
	{
		"RishabhRD/nvim-cheat.sh",
		config = function()
			local map = require("tmtl.utils").map
			map("n", "<leader>cr", function()
				vim.cmd([[Cheat rust ]])
			end, { desc = "[C]heatsheet - [R]ust" })
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"jedrzejboczar/possession.nvim",
		config = {
			commands = {
				save = "SSave",
				load = "SLoad",
				delete = "SDelete",
				list = "SList",
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"samjwill/nvim-unception",
		config = function()
			vim.g.unception_open_buffer_in_new_tab = true
		end,
	},
	{
		"nat-418/boole.nvim",
		config = {
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
		},
	},
}

return M
