vim.lsp.config("*", {
  on_attach = function()
    require("tmtl.utils").on_attach_lsp()
  end,
  root_markers = { ".git" },
})

vim.lsp.enable({ "lua_ls", "html" })
