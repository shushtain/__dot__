local function print_later(str, ms)
  vim.defer_fn(function()
    if vim.g.u_pager then
      print(str)
    end
  end, ms or 500)
end

local function get_marks()
  local raw = vim.fn.execute("marks")
  raw = vim.split(raw, "\n")
  local marks = {}
  for i, mark in ipairs(raw) do
    if i > 2 then
      local char, _, _, loc = mark:match("^%s*(%S+)%s+(%S+)%s+(%S+)%s+(.+)%s*$")
      if char and loc then
        table.insert(marks, " " .. char .. " " .. loc)
      end
    end
  end
  return vim.fn.join(marks, "\n")
end

-- local function get_spellings()
--   local raw = vim.fn.execute("normal! z=")
--   raw = vim.split(raw, "\n")
--   local spellings = {}
--   for i, spelling in ipairs(raw) do
--     if i > 1 and i < 12 then
--       local num, word = spelling:match('^%s*(%d+)%s*"(.+)"%s*$')
--       if num and word then
--         table.insert(spellings, " " .. num .. " " .. word)
--       end
--     end
--   end
--   return vim.fn.join(spellings, "\n")
-- end

-- local function get_registers()
--   local raw = vim.fn.execute("registers")
--   raw = vim.split(raw, "\n")
--   local registers = {}
--   for i, register in ipairs(raw) do
--     if i > 2 then
--       print(register)
--       local _, reg, text = register:match("^%s*(%S+)%s+(%S+)%s%s(.+)$")
--       if reg and text then
--         table.insert(registers, " " .. reg .. text)
--       end
--     end
--   end
--   return vim.fn.join(registers, "\n")
-- end

vim.keymap.set("n", "m", function()
  vim.g.u_pager = true
  print_later(get_marks())
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! m" .. ch)
end)

vim.keymap.set("n", "'", function()
  vim.g.u_pager = true
  print_later(get_marks())
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! '" .. ch)
end)

vim.keymap.set("n", "`", function()
  vim.g.u_pager = true
  print_later(get_marks())
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! `" .. ch)
end)

-- vim.keymap.set("n", "+", function()
--   vim.g.u_pager = true
--   print(get_spellings())
--   local ch = vim.fn.getcharstr()
--   vim.g.u_pager = false
--   if ch:match("%d") then
--     vim.cmd("normal! " .. ch .. "z=")
--   end
-- end)
