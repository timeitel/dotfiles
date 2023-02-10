local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function(client, bufnr)
    require("lsp-format-modifications").attach(client, bufnr, { format_on_save = true })
  end,
})
