local M = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "goimports", "gofmt" },
      templ = { "templ", "rustywind" },
      javascript = { "prettierd", "rustywind" },
      javascriptreact = { "prettierd", "rustywind" },
      typescript = { "prettierd", "rustywind" },
      typescriptreact = { "prettierd", "rustywind" },
    },

    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}

return M
