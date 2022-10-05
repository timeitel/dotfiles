local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
    return
end

local protocol = require("vim.lsp.protocol")

local on_attach = function(_, bufnr)
    local function buf_map(m, k, v)
        vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr })
    end

    -- TODO: format the range after accepting code action
    -- Diagnostics
    buf_map("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>zz<cmd>CodeActionMenu<cr>") -- TODO: get cursor position, spawn menu at location then check if any results, float if no actions
    buf_map("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>zz<cmd>CodeActionMenu<cr>")
    buf_map("n", "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    buf_map("n", "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    buf_map("n", "<leader>da", "<cmd>CodeActionMenu<cr>")
    buf_map("n", "<leader>dh", "<cmd>lua vim.diagnostic.open_float()<cr>")
    buf_map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>")
    buf_map(
        "n",
        "<leader>do",
        "<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<cr>"
    )
    buf_map("n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- LSP
    buf_map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>zz")
    buf_map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>")
    buf_map(
        "n",
        "gr",
        "<cmd>lua require('telescope.builtin').lsp_references({show_line = false, include_declaration = false })<cr>"
    )
    buf_map("n", "gd", "<Cmd>Telescope lsp_definitions<cr>zz")
    buf_map("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<cr>zz")
    buf_map("n", "gI", "<Cmd>lua vim.lsp.buf.implementation()<cr>zz")
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
        client.resolved_capabilities.document_formatting = false -- done by prettierd
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
