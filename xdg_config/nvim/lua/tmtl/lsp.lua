local diag_opts = {
  virtual_text = {
    prefix = "●",
    virt_text_pos = "right_align",
  },
  update_in_insert = true,
  underline = false,
  virtual_lines = false,
}

vim.diagnostic.config(diag_opts)

vim.lsp.config("*", {
  on_attach = function()
    require("tmtl.utils").on_attach_lsp()

    vim.keymap.set("n", "<leader>ll", function()
      if diag_opts.virtual_text == false then
        diag_opts.virtual_text = {
          prefix = "●",
          virt_text_pos = "right_align",
        }
        diag_opts.virtual_lines = false
      else
        diag_opts.virtual_text = false
        diag_opts.virtual_lines = true
      end

      vim.diagnostic.config(diag_opts)
    end, { desc = "[L]SP toggle virtual lines", buffer = 0 })
  end,
  root_markers = { ".git" },
})

vim.lsp.enable({ "lua_ls", "html", "tailwindcss", "gopls", "ts_ls" })

vim.lsp.protocol.CompletionItemKind = {
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

local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
