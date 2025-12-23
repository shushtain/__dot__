---@type vim.lsp.Config
return {
  cmd = { "tinymist", "lsp" },
  filetypes = { "typst" },
  root_markers = { ".git" },
  settings = {
    exportPdf = "onSave", -- onType|onSave|never
    -- systemFonts = false,
    -- semanticTokens = "disable",
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    lint = {
      enabled = true,
      when = "onSave",
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("uLspFormat", { clear = false }),
      buffer = bufnr,
      callback = function()
        if not vim.g.u_manual_formatting then
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
        end
      end,
    })
  end,
}
