Utils = {}

Utils.map = function(m, k, v, opts)
    opts = opts or {}
    opts.silent = true
    opts.noremap = true
    vim.keymap.set(m, k, v, opts)
end

Utils.getVisualSelection = function()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ""
    end
end
