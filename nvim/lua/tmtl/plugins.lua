return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-file-browser.nvim" })

    -- LSP
    use("neovim/nvim-lspconfig")
    use('L3MON4D3/LuaSnip')
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("saadparwaiz1/cmp_luasnip")
    use("tamago324/cmp-zsh")
    use("onsails/lspkind-nvim")

    use("simrat39/rust-tools.nvim")

    use("jose-elias-alvarez/null-ls.nvim") -- non-LSP sources

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- 10000x developer
    use("bkad/CamelCaseMotion")
    use("inkarkat/vim-ReplaceWithRegister")
    use("michaeljsmith/vim-indent-object")
    use("tommcdo/vim-exchange")
    use("tpope/vim-commentary")
    use("tpope/vim-surround")
    use({ 'jiangmiao/auto-pairs' }) -- TODO: test and keep?
    use("ThePrimeagen/harpoon")
    use("RishabhRD/popfix")
    use("RishabhRD/nvim-lsputils")
    use({
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    })

    -- Git
    use({ 'lewis6991/gitsigns.nvim' })
    use({ 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' } })

    -- Styling
    use("monsonjeremy/onedark.nvim")
    use("kyazdani42/nvim-web-devicons")
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' } -- TODO: replace with winbar on nvim 0.8
    use({ 'nvim-lualine/lualine.nvim' })
end)
