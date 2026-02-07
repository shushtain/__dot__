local group = vim.api.nvim_create_augroup("uFormatOnSave", { clear = false })

local external = {
  html = "html",
  xml = "html",
  css = "css",
  javascript = "babel",
  typescript = "typescript",
  markdown = "markdown",
  yaml = "yaml",
  json = "json",
  jsonc = "jsonc",
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function(args)
    if vim.g.u_manual_formatting then
      return
    end

    local filetype = vim.bo[args.buf].filetype
    local parser = external[filetype]
    if not parser then
      return
    end

    local filepath = vim.api.nvim_buf_get_name(args.buf)
    local cmd = { "prettier", "--stdin-filepath", filepath, "--parser", parser }
    if filetype == "json" or filetype == "jsonc" then
      table.insert(cmd, "--trailing-comma")
      table.insert(cmd, "none")
    end

    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local result = vim.system(cmd, { text = true, stdin = lines }):wait(500)
    if result.code ~= 0 then
      vim.notify(
        result.code .. "/" .. result.signal .. ": " .. result.stderr,
        vim.log.levels.WARN
      )
      return
    end
    if not result.stdout then
      return
    end

    lines = vim.split(result.stdout, "\n")
    while #lines > 0 and lines[1] == "" do
      table.remove(lines, 1)
    end
    while #lines > 0 and lines[#lines] == "" do
      table.remove(lines)
    end

    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    if vim.tbl_contains(external, filetype) then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if
      not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("uLspFormat", { clear = false }),
        buffer = args.buf,
        callback = function()
          if not vim.g.u_manual_formatting then
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end
        end,
      })
    end
  end,
})
