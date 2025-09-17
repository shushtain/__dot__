return {
  "stevearc/conform.nvim",
  -- enabled = false,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local formatters = {
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
    }

    require("conform").setup({
      notify_on_error = true,
      notify_no_formatters = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never",
      },
      formatters_by_ft = formatters,
    })
  end,
}
