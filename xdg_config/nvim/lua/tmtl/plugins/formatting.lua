local M = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "rustywind" },
      javascriptreact = { "prettierd", "rustywind" },
      typescript = { "prettierd", "rustywind" },
      typescriptreact = { "prettierd", "rustywind" },

      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "goimports", "gofmt" },
      html = { "djlint", "rustywind" },
      yaml = { "yamlfix" },
      sql = { "pg_format" },
    },

    format_after_save = {
      lsp_format = "fallback",
    },
  },
}

return M
