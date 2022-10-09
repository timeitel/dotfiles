local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
    return
end

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = border,
})

local protocol = require("vim.lsp.protocol")

local on_attach = function(_, bufnr)
    local function buf_map(m, k, v)
        vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr })
    end

    -- TODO: <C-.> for repeat last plugin action / commands
    -- TODO: lsp signature help being blocked by nvim cmp, move signature floating window to the top
    -- TODO: try using on_list to conditionally call telescope when > 1 reference etc
    -- TODO: format the range after accepting code action
    -- Diagnostics
    buf_map("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr><cmd>CodeActionMenu<cr>") -- TODO: get cursor position, spawn menu at location then check if any results, float if no actions
    buf_map("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr><cmd>CodeActionMenu<cr>")
    buf_map("n", "<leader>dj", function()
        vim.diagnostic.goto_next({ float = { border = border } })
    end)
    buf_map("n", "<leader>dk", function()
        vim.diagnostic.goto_prev({ float = { border = border } })
    end)
    buf_map("n", "<leader>da", "<cmd>CodeActionMenu<cr>")
    buf_map("n", "<leader>dh", function()
        vim.diagnostic.open_float(0, { scope = "line", border = border })
    end)
    buf_map("n", "<leader>dl", function()
        vim.cmd("Telescope diagnostics")
    end)

    -- LSP
    buf_map("n", "<leader>lr", function()
        vim.lsp.buf.rename()
    end)
    buf_map("n", "<leader>ls", function()
        vim.lsp.buf.signature_help()
    end)
    buf_map("n", "<leader>li", function()
        vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
    end)
    buf_map("i", "<C-S-Space>", function()
        vim.lsp.buf.signature_help()
    end)
    buf_map("n", "gD", function()
        vim.lsp.buf.declaration()
    end)
    buf_map("n", "K", function()
        vim.lsp.buf.hover()
    end)
    buf_map("n", "gr", function()
        require("telescope.builtin").lsp_references({ show_line = false, include_declaration = false })
    end)
    buf_map("n", "gd", function()
        vim.cmd("Telescope lsp_definitions")
    end)
    buf_map("n", "gt", function()
        vim.lsp.buf.type_definition()
    end)
    buf_map("n", "gI", function()
        vim.lsp.buf.implementation()
    end)
end

protocol.CompletionItemKind = {
    "", -- Text
    "", -- Method
    "", -- Function
    "", -- Constructor
    "", -- Field
    "", -- Variable
    "", -- Class
    "ﰮ", -- Interface
    "", -- Module
    "", -- Property
    "", -- Unit
    "", -- Value
    "", -- Enum
    "", -- Keyword
    "﬌", -- Snippet
    "", -- Color
    "", -- File
    "", -- Reference
    "", -- Folder
    "", -- EnumMember
    "", -- Constant
    "", -- Struct
    "", -- Event
    "ﬦ", -- Operator
    "", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup({
    on_attach = function(client, buffnr)
        on_attach(client, buffnr)
        client.server_capabilities.documentFormattingProvider = false -- done by prettierd
    end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities,
})

nvim_lsp.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
    capabilities = capabilities,
})

-- nvim_lsp.rust.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
    },
    update_in_insert = true,
    float = {
        source = "always", -- Or "if_many"
    },
})
