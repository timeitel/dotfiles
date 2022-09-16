-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("gruvbox-community/gruvbox")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- LSP
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-document-symbol")
	use("saadparwaiz1/cmp_luasnip")
	use("tamago324/cmp-zsh")

	use("simrat39/rust-tools.nvim")

	use("jose-elias-alvarez/null-ls.nvim")

	-- 10000x developer
	use("bkad/CamelCaseMotion")
	use("inkarkat/vim-ReplaceWithRegister")
	use("michaeljsmith/vim-indent-object")
	use("tommcdo/vim-exchange")
	use("tpope/vim-commentary")
	use("tpope/vim-surround")

	use("ThePrimeagen/harpoon")

	use("RishabhRD/popfix")
	use("RishabhRD/nvim-lsputils")
end)
