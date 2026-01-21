vim.api.nvim_create_user_command("DiffOrig", function()
  vim.cmd("diffthis")
  vim.cmd("vertical new")
  vim.bo.buftype = "nofile"
  vim.cmd("read ++edit #")
  vim.cmd("0d_")
  vim.cmd("diffthis")
end, {})

-- vim.api.nvim_create_user_command("PipeCurrent", function(cmd)
--   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--   local res = vim.system(cmd.fargs, { text = true, stdin = lines }):wait(500)
--   if res.code ~= 0 then
--     vim.notify(res.code .. "/" .. res.signal .. ": " .. res.stderr)
--     return
--   end
--   vim.print(res.stdout)
--   -- do something with res.stdout on success if you want
--   -- save it to a file or something... vim.fn.writefile()
-- end, { nargs = "+", complete = "command" })
