-- :E cmd
vim.api.nvim_create_user_command("I", function(cmd)
  local result = vim.fn.execute(cmd.args)
  local rows = vim.split(result, "\n")
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
  vim.api.nvim_open_win(buf, true, { split = "right" })
end, { nargs = "+" })
