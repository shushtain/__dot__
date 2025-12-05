vim.g.u_todos = true

local groups = {
  -- ERROR: 𜱃𜱃𜱃𜱃𜱃
  --   FIX: 𜱃𜱃𜱃𜱃𜱃
  error = {
    important = true,
    kinds = { "ERROR", "FIX", "BUG", "ISSUE", "FIXME", "FIXIT" },
    color = "#FF4A20",
  },
  -- WARN:  𜱃𜱃𜱃𜱃𜱃
  -- :XXX:  𜱃𜱃𜱃𜱃𜱃
  warn = {
    important = true,
    kinds = { "WARN", "WARNING", "XXX", "HACK" },
    color = "#FF8000",
  },
  -- INFO:  𜱃𜱃𜱃𜱃𜱃
  -- other  𜱃𜱃𜱃𜱃𜱃
  info = {
    important = false,
    kinds = { "INFO", "NOTE" },
    color = "#81AE64",
  },
  -- TEST:  𜱃𜱃𜱃𜱃𜱃
  --    --  𜱃𜱃𜱃𜱃𜱃
  test = {
    important = true,
    kinds = { "TEST", "TESTING", "PASSED", "FAILED", "PASS", "FAIL" },
    color = "#47DDAA",
  },
  -- TODO:  𜱃𜱃𜱃𜱃𜱃
  --        𜱃𜱃𜱃𜱃𜱃
  todo = {
    important = true,
    kinds = { "TODO" },
    color = "#1AB9D1",
  },
  -- PERF:  𜱃𜱃𜱃𜱃𜱃
  --        𜱃𜱃𜱃𜱃𜱃
  perf = {
    important = true,
    kinds = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" },
    color = "#B575FF",
  },
  -- :::    𜱃𜱃𜱃𜱃𜱃
  --    ~>: 𜱃𜱃𜱃𜱃𜱃
  mark = {
    important = false,
    kinds = { "::", "~>" },
    pattern = "(::|\\\\~\\\\>):",
    color = "#FF6299",
  },
}

local function get_sym(kind)
  return "TODO_" .. kind:gsub("[^%w]", "_")
end

for cat, group in pairs(groups) do
  local pattern = vim.fn.join(group.kinds, "|")
  if not group.pattern then
    pattern = "(" .. pattern .. "):"
    groups[cat].pattern = pattern
  end
  local sym = get_sym(group.kinds[1])
  vim.api.nvim_set_hl(0, sym, { fg = group.color })
  vim.fn.sign_define(sym, { text = "⧺", texthl = sym })
end

local function get_query(node, group)
  if group and #group.kinds > 0 then
    local id = "@" .. get_sym(group.kinds[1])
    return ([[
      ((%s) %s 
      (#match? %s "%s")) 
    ]]):format(node, id, id, group.pattern)
  else
    return ("(%s) @comment"):format(node)
  end
end

local augroup = vim.api.nvim_create_augroup("uTodos", { clear = false })
local ns = vim.api.nvim_create_namespace("uTodos")
local queries = {}

vim.api.nvim_create_autocmd(
  { "CursorHold", "BufEnter", "InsertLeave", "BufWritePost" },
  {
    group = augroup,
    callback = function(args)
      if not vim.g.u_todos then
        return nil
      end
      vim.api.nvim_buf_clear_namespace(args.buf, ns, 0, -1)
      vim.fn.sign_unplace("uTodos", { buffer = args.buf })

      local ft = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft

      local parser =
        vim.treesitter.get_parser(args.buf, lang, { error = false })
      local root = nil
      if parser then
        parser = parser:parse()
        if parser and parser[1] then
          root = parser[1]:root()
        end
      end
      if not root then
        return nil
      end

      local cache = queries[lang] or {}
      local ok, obj

      local comment = "comment"
      cache[comment] = cache[comment] or {}
      if not cache[comment].gen then
        ok, obj = pcall(vim.treesitter.query.parse, lang, get_query(comment))
        cache[comment].gen = ok and obj or nil
      end

      if not cache[comment].gen then
        comment = "line_comment"
        cache[comment] = cache[comment] or {}
        if not cache[comment].gen then
          ok, obj = pcall(vim.treesitter.query.parse, lang, get_query(comment))
          cache[comment].gen = ok and obj or nil
        end
      end

      if cache[comment].gen then
        local comments = {}
        for _, node, _, _ in
          ---@diagnostic disable-next-line: need-check-nil
          cache[comment].gen:iter_captures(root, args.buf, 0, -1)
        do
          local srow, scol, erow, ecol = node:range()
          comments[srow] = { srow, scol, erow, ecol }
        end

        local todos = {}
        for cat, group in pairs(groups) do
          todos[cat] = {}
          if not cache[comment][cat] then
            ok, obj =
              pcall(vim.treesitter.query.parse, lang, get_query(comment, group))
            cache[comment][cat] = ok and obj or nil
          end
          if cache[comment][cat] then
            for _, node, _, _ in
              ---@diagnostic disable-next-line: need-check-nil
              cache[comment][cat]:iter_captures(root, args.buf, 0, -1)
            do
              local srow, scol, erow, ecol = node:range()
              table.insert(todos[cat], { srow, scol, erow, ecol })
              comments[srow] = nil
            end
          end
        end

        for cat, headers in pairs(todos) do
          local sym = get_sym(groups[cat].kinds[1])
          for _, header in ipairs(headers) do
            local srow, scol, erow, ecol = table.unpack(header)
            vim.fn.sign_place(0, "uTodos", sym, args.buf, {
              lnum = srow + 1,
              priority = 8,
            })
            vim.api.nvim_buf_set_extmark(args.buf, ns, srow, scol, {
              end_row = erow,
              end_col = ecol,
              hl_group = sym,
            })
            while true do
              local child = comments[erow + 1]
              if not child then
                break
              end
              srow, scol, erow, ecol = table.unpack(child)
              vim.api.nvim_buf_set_extmark(args.buf, ns, srow, scol, {
                end_row = erow,
                end_col = ecol,
                hl_group = sym,
              })
              comments[erow] = nil
            end
          end
        end
      end

      comment = "block_comment"
      cache[comment] = cache[comment] or {}
      for cat, group in pairs(groups) do
        if not cache[comment][cat] then
          ok, obj =
            pcall(vim.treesitter.query.parse, lang, get_query(comment, group))
          cache[comment][cat] = ok and obj or nil
        end
        if cache[comment][cat] then
          local sym = get_sym(groups[cat].kinds[1])
          for _, node, _, _ in
            cache[comment][cat]:iter_captures(root, args.buf, 0, -1)
          do
            local srow, scol, erow, ecol = node:range()
            vim.fn.sign_place(0, "uTodos", sym, args.buf, {
              lnum = srow + 1,
              priority = 8,
            })
            vim.api.nvim_buf_set_extmark(args.buf, ns, srow, scol, {
              end_row = erow,
              end_col = ecol,
              hl_group = sym,
            })
          end
        end
      end

      queries[lang] = cache
    end,
  }
)

local keywords = {}
for _, group in pairs(groups) do
  for _, keyword in ipairs(group.kinds) do
    table.insert(keywords, keyword)
  end
end
local prompt_keywords = "(" .. table.concat(keywords, "|") .. "):"
vim.keymap.set("n", "<Leader>fT", function()
  require("fzf-lua").live_grep({ search = prompt_keywords, no_esc = true })
end, { desc = "Find : Todos All" })

local important = {}
for _, group in pairs(groups) do
  if group.important then
    for _, keyword in ipairs(group.kinds) do
      table.insert(important, keyword)
    end
  end
end
local prompt_important = "(" .. table.concat(important, "|") .. "):"
vim.keymap.set("n", "<Leader>ft", function()
  require("fzf-lua").live_grep({ search = prompt_important, no_esc = true })
end, { desc = "Find : Todos" })

vim.keymap.set("n", "<Leader>tt", function()
  vim.g.u_todos = not vim.g.u_todos
  if not vim.g.u_todos then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    vim.fn.sign_unplace("uTodos", { buffer = 0 })
  end
end, { desc = "Toggle : Todos" })
