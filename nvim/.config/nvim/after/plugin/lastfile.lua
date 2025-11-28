local group = vim.api.nvim_create_augroup("uLastFile", { clear = false })

local state = vim.fn.stdpath("state") .. "/lastfile/"
local function hash()
  return state .. vim.fn.sha256(vim.fn.getcwd()) .. ".data"
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function(env)
    if
      vim.bo[env.buf].buftype == ""
      and vim.bo[env.buf].filetype == ""
      and vim.api.nvim_buf_get_name(env.buf) == ""
      and vim.api.nvim_buf_line_count(env.buf) == 1
    then
      local path = hash()
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
    local filetype = vim.bo[env.buf].filetype
    local bufname = vim.api.nvim_buf_get_name(env.buf)
    local buftype = vim.bo[env.buf].buftype
    if bufname ~= "" and buftype == "" and filetype ~= "gitcommit" then
      if vim.fn.isdirectory(state) == 0 then
        vim.fn.mkdir(state, "p")
      end
      local path = hash()
      local curpos = vim.fn.getcurpos()
      local tbl = { bufname, curpos[2], curpos[3] }
      vim.fn.writefile(tbl, path)
    end
  end,
})

vim.keymap.set("n", "<Leader>ze", function()
  vim.api.nvim_del_augroup_by_id(group)
  vim.fn.delete(hash())
  vim.notify("LastFile is off")
end, { desc = "Purge : LastFile" })

vim.keymap.set("n", "<Leader>zo", function()
  vim.fn.delete(state, "rf")
  vim.notify("Purged LastFile cache")
end, { desc = "Purge : LastFile All" })
