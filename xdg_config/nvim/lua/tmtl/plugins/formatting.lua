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

    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}

return M
