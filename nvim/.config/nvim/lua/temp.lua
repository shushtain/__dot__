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

-- local brackets_open = { ["("] = ")", ["["] = "]", ["{"] = "}", ["<"] = ">" }
-- local brackets_closed = { [")"] = "(", ["]"] = "[", ["}"] = "{", [">"] = "<" }
-- vim.keymap.set("n", "g-", function()
--   --[[ FINISH THE KEYMAP g-({, g-{(, etc ]]
--   -- read the next character typed (existing bracket)
--   local old = vim.fn.getcharstr()
--   -- make sure it's a valid bracket
--   if not brackets_open[old] and not brackets_closed[old] then
--     return
--   end
--   -- read the next character typed (replacement bracket)
--   local new = vim.fn.getcharstr()
--   -- make sure it's a valid bracket
--   if not brackets_open[new] and not brackets_closed[new] then
--     return
--   end
--
--   --[[ REMEMBER CURSOR POSITION ]]
--   local cursor = vim.fn.getcurpos()
--   -- we don't need the first element for later
--   table.remove(cursor, 1)
--
--   --[[ FIND THE RIGHT PAIRS ]]
--   local open = new
--   local closed = brackets_open[new]
--   -- if you type g-)}, we need to shuffle what is open/closed
--   if not closed then
--     open = brackets_closed[new]
--     closed = new
--   end
--
--   --[[ REPLACE BRACKETS ]]
--   -- select around old bracket
--   vim.cmd("normal! va" .. old)
--   -- deselect (call ESCAPE) to end up at closing bracket
--   vim.cmd("normal! \27")
--   -- replace closing bracket (cl since you don't want r)
--   vim.cmd("normal! cl" .. closed .. "\27")
--   -- select old selection with "gv", switch to its other end with "o"
--   vim.cmd("normal! gvo\27")
--   -- replace opening bracket
--   vim.cmd("normal! cl" .. open .. "\27")
--
--   --[[ RESTORE CURSOR POSITION ]]
--   vim.fn.cursor(cursor)
-- end, { desc = "Surround : Replace" })
