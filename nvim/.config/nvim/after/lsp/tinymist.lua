---@type vim.lsp.Config
return {
  cmd = { "tinymist", "lsp" },
  filetypes = { "typst" },
  -- root_markers = { ".git" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { ".git" })
    on_dir(root or vim.fn.getcwd())
  end,
  settings = {
    outputPath = "$root/target/$dir/$name",
    exportPdf = "never", -- onType|onSave|never
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

    vim.keymap.set("n", "<leader>p.p", function()
      client:exec_cmd({
        title = "pin",
        command = "tinymist.pinMain",
        arguments = { vim.api.nvim_buf_get_name(0) },
      }, { bufnr = bufnr })
    end, { buffer = bufnr, desc = "LSP : Pin : Set" })

    vim.keymap.set("n", "<leader>p.u", function()
      client:exec_cmd({
        title = "unpin",
        command = "tinymist.pinMain",
        arguments = { vim.v.null },
      }, { bufnr = bufnr })
    end, { buffer = bufnr, desc = "LSP : Pin : Del" })

    vim.keymap.set("n", "<leader>.", function()
      client:exec_cmd({
        title = "pdf",
        command = "tinymist.exportPdf",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
      }, { bufnr = bufnr })
    end, { buffer = bufnr, desc = "Typst : Export PDF" })
  end,
}
