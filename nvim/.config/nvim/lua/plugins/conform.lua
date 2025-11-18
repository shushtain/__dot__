return {
  "stevearc/conform.nvim",
  -- enabled = false,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      notify_on_error = true,
      notify_no_formatters = false,
      format_on_save = { timeout_ms = 500, lsp_format = "never" },
      formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
      },
    })

    require("conform").formatters.prettier = {
      condition = function()
        return not vim.g.u_manual_formatting
      end,
      append_args = function(_, ctx)
        local ft = vim.bo[ctx.buf].filetype
        if ft == "json" or ft == "jsonc" then
          return { "--trailing-comma", "none" }
        end
        return {}
      end,
    }
  end,
}
