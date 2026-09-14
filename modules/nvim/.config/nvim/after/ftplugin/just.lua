vim.b.u_delim = " \\"

vim.keymap.set("n", "<Leader>.", function()
  local file = vim.api.nvim_buf_get_name(0)
  vim.system(
    { "just", "--summary", "--unsorted", "-f", file },
    { text = true },
    function(obj)
      vim.schedule(function()
        if obj.code == 0 and obj.stdout then
          local list = vim.split(obj.stdout, " ")
          list = vim.tbl_filter(function(v)
            local ignore = { "", "default", "all" }
            return not vim.tbl_contains(ignore, v)
          end, list)
          table.insert(list, 1, "all:")
          local out = vim.fn.join(list, " ")
          vim.api.nvim_paste(out, false, -1)
        else
          vim.notify(("[just] %d:\n%s"):format(obj.code, obj.stderr))
        end
      end)
    end
  )
end, { buffer = true, desc = "Just : All" })

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("just")
