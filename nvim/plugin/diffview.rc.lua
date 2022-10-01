local actions = require("diffview.actions")
-- print(vim.inspect(neogit))

-- tab to select entry
local shared_maps = {
    ["q"] = "<cmd>DiffviewClose<cr>",
    ["<C-h>"] = "<cmd>DiffviewClose<cr>",
    ["f"] = "<cmd>DiffviewToggleFiles<cr>",
    ["<C-Space>"] = actions.select_entry,
    ["<C-e>"] = actions.scroll_view(1),
    ["<C-y>"] = actions.scroll_view(-1),
    ["<C-d>"] = actions.scroll_view(10),
    ["<C-u>"] = actions.scroll_view(-10),
    ["gf"] = actions.goto_file_edit,
    ["s"] = actions.toggle_stage_entry, -- TODO: stage and unstage
    -- ["R"] = function() -- TODO: reset /discard all changes
    --     local inp = vim.fn.input("Are you sure you'd like to discard changes ALL CHANGES? (y/n): ")
    --     if string.lower(inp) == "y" then
    --         actions.()
    --     end
    --     print("")
    -- end,
    ["X"] = function()
        local inp = vim.fn.input("Are you sure you'd like to discard changes? (y/n): ")
        if string.lower(inp) == "y" then
            actions.restore_entry()
        end
        print("")
    end,
    ["C"] = function()
        vim.cmd("DiffviewClose")
        vim.cmd("Neogit")
        vim.cmd("Neogit commit")
    end,
}

require("diffview").setup({
    view = {
        merge_tool = {
            layout = "diff3_mixed",
        },
    },
    file_panel = {},
    keymaps = {
        view = shared_maps,
        file_panel = shared_maps,
        file_history_panel = shared_maps,
    },
})
