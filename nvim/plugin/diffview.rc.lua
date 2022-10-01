local actions = require("diffview.actions")
-- print(vim.inspect(actions))

local keymaps = {
    ["q"] = "<cmd>DiffviewClose<cr>",
    ["f"] = "<cmd>DiffviewToggleFiles<cr>",
    ["<C-e>"] = actions.scroll_view(1),
    ["<C-y>"] = actions.scroll_view(-1),
    ["<C-d>"] = actions.scroll_view(10),
    ["<C-u>"] = actions.scroll_view(-10),
    ["gf"] = actions.goto_file_edit,
    ["s"] = actions.toggle_stage_entry,
    -- ["x"] = actions.,
    -- TODO: discard changes
}

local viewKeymaps = {
    ["q"] = "<cmd>DiffviewClose<cr>",
    ["f"] = "<cmd>DiffviewToggleFiles<cr>",
    ["<C-e>"] = actions.scroll_view(1),
    ["<C-y>"] = actions.scroll_view(-1),
    ["<C-d>"] = actions.scroll_view(10),
    ["<C-u>"] = actions.scroll_view(-10),
    ["gf"] = actions.goto_file_edit,
    ["s"] = actions.toggle_stage_entry,
    -- ["x"] = actions.,
    -- TODO: discard changes
}

require("diffview").setup({
    view = {
        merge_tool = {
            layout = "diff3_mixed",
        },
    },
    file_panel = {},
    keymaps = {
        view = viewKeymaps,
        file_panel = keymaps,
        file_history_panel = keymaps,
    },
})
