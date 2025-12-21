local function print_later(callback, ms)
  vim.defer_fn(function()
    if vim.g.u_pager then
      vim.o.more = false
      vim.api.nvim_echo(callback(), false, {})
      vim.o.more = true
    end
  end, ms or 1000)
end

local function get_marks()
  local raw = vim.fn.execute("marks", "silent")
  local raw_lines = vim.split(raw, "\n")
  local lines = {}
  for i, line in ipairs(raw_lines) do
    if i > 2 then
      local k, _, _, v = line:match("^%s*(%S+)%s+(%S+)%s+(%S+)%s+(.+)%s*$")
      if k and v then
        table.insert(lines, { k, "Special" })
        table.insert(lines, { (" %s\n"):format(v), "@comment.documentation" })
      end
    end
  end
  return lines
end

local function get_spellings()
  local raw = vim.fn.execute("normal! z=")
  local raw_lines = vim.split(raw, "\n")
  local lines = {}
  for i, line in ipairs(raw_lines) do
    if i > 1 and i < 12 then
      local k, v = line:match('^%s*(%d+)%s*"(.+)"%s*$')
      if k and v then
        table.insert(lines, { k, "Special" })
        table.insert(lines, { (" %s\n"):format(v), "@comment.documentation" })
      end
    end
  end
  return lines
end

local function get_registers()
  local raw = vim.fn.execute("registers")
  local raw_lines = vim.split(raw, "\n")
  local lines = {}
  for i, line in ipairs(raw_lines) do
    if i > 2 then
      local _, k, v = line:match('^%s*(%S+)%s+"(%S+)%s+(.+)$')
      if k and v then
        table.insert(lines, { k, "Special" })
        table.insert(lines, { (" %s\n"):format(v), "@comment.documentation" })
      end
    end
  end
  return lines
end

vim.keymap.set("n", "m", function()
  vim.g.u_pager = true
  print_later(get_marks)
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! m" .. ch)
end)

vim.keymap.set("n", "'", function()
  vim.g.u_pager = true
  print_later(get_marks)
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! `" .. ch)
end)

vim.keymap.set("n", "`", function()
  vim.g.u_pager = true
  print_later(get_marks)
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.cmd("normal! `" .. ch)
end)

vim.keymap.set("n", '"', function()
  vim.g.u_pager = true
  print_later(get_registers)
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  vim.api.nvim_feedkeys('"' .. ch, "n", false)
end)

vim.keymap.set("n", "z=", function()
  vim.g.u_pager = true
  print_later(get_spellings, 0)
  local ch = vim.fn.getcharstr()
  vim.g.u_pager = false
  if ch:match("%d") then
    vim.cmd("normal! " .. ch .. "z=")
  end
end)
