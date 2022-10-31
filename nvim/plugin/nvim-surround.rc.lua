require("nvim-surround").setup({
    keymaps = {
        normal = "gs",
        normal_cur = "gss",
        normal_line = "gS",
        normal_cur_line = "gSS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
    },
})
