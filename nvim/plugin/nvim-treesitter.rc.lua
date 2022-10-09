local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

ts.setup({
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "tsx",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
    },
    autotag = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding xor succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = false, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["<C-]>"] = "@function.outer",
            },
            goto_next_end = { -- TODO: map these?
                ["<C-'>"] = "@function.outer",
            },
            goto_previous_start = {
                ["<C-[>"] = "@function.outer",
            },
            goto_previous_end = {
                ["<C-;>"] = "@function.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = "none",
            peek_definition_code = {
                ["<leader>lf"] = "@function.outer",
            },
        },
    },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
