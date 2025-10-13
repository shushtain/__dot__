local group = vim.api.nvim_create_augroup("uOpenLast", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function(env)
    local bufname = vim.api.nvim_buf_get_name(env.buf)
    local line_count = vim.api.nvim_buf_line_count(env.buf)

    if bufname == "" and line_count == 1 then
      local cache = vim.fn.stdpath("state") .. "/open_last/"
      local cwd = vim.fn.getcwd():gsub("/", "_")
      local path = cache .. cwd
      if vim.fn.filereadable(path) == 1 then
        local file = vim.fn.readfile(path)
        local filename = file[1]
        if vim.fn.filereadable(filename) == 1 then
          vim.schedule(function()
            vim.cmd("e " .. filename)
            vim.fn.bufload(filename)
            local curpos = { file[2], file[3] }
            vim.fn.cursor(curpos)
            vim.cmd("normal! zz")
          end)
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = group,
  callback = function(env)
    local bufname = vim.api.nvim_buf_get_name(env.buf)
    local buftype = vim.bo[env.buf].buftype
    if bufname ~= "" and buftype == "" then
      local cache = vim.fn.stdpath("state") .. "/open_last/"
      if vim.fn.isdirectory(cache) == 0 then
        vim.fn.mkdir(cache, "p")
      end
      local cwd = vim.fn.getcwd():gsub("/", "_")
      local path = cache .. cwd
      local curpos = vim.fn.getcurpos()
      local tbl = { bufname, curpos[2], curpos[3] }
      vim.fn.writefile(tbl, path)
    end
  end,
})

vim.keymap.set("n", "<Leader>z", function()
  local cache = vim.fn.stdpath("state") .. "/open_last/"
  vim.fn.delete(cache, "rf")
  -- vim.api.nvim_del_augroup_by_id(group)
  vim.notify("Purged 'Open Last' cache", vim.log.levels.INFO)
end, { desc = "Purge Open Last" })
