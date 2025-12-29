local augroup = vim.api.nvim_create_augroup("uLspFixMdLine", { clear = true })
local ns = vim.api.nvim_create_namespace("uLspFixMdLine")
local ft = "markdown"

vim.api.nvim_create_autocmd("FileType", {
  pattern = ft,
  group = augroup,
  callback = function(args)
    vim.api.nvim_buf_clear_namespace(args.buf, ns, 0, -1)

    local parser = vim.treesitter.get_parser(args.buf, ft, { error = false })
    if not parser then
      vim.notify("No root", vim.log.levels.WARN)
      return nil
    end

    local root = parser:parse()[1]:root()
    local ok, obj = pcall(
      vim.treesitter.query.parse,
      ft,
      [[ ((inline) @lsp_sep
         (#match? @lsp_sep "───+")) ]]
    )
    if not ok or not obj then
      vim.notify("No obj", vim.log.levels.WARN)
      return nil
    end

    for _, node, _, _ in obj:iter_captures(root, args.buf, 0, -1) do
      local srow, _, erow, _ = node:range()
      local lines = vim.api.nvim_buf_get_lines(args.buf, srow, erow, false)
      for i, line in ipairs(lines) do
        if line:match("^%s*───+%s*") then
          vim.api.nvim_buf_set_extmark(args.buf, ns, srow + i - 1, 0, {
            end_col = #line - 1,
            hl_group = "NonText",
          })
        end
      end
    end
  end,
})
