# One-file TODO plugin

> Neovim 0.11.5

Using `TODO:`, `FIXME:` and similar comments is an unofficial convention at this point. You don't need fancy plugins to highlight them, although you need the majestic `vim.treesitter` capabilities to do it effectively and efficiently.

Features:

- Highlights and signcolumn marks
- Custom groups, aliases, special marks
- Multi-line line comments
- Support for block comments

I'm sure there are ways to optimize performance further, but this implementation feels faster than existing plugins. Most of them made my old laptop stutter, which was the inspiration for writing this one. I hope this inspires you to write your own plugins.

## Development

Create `after/plugin/todos.lua` in your config and mix-match the following:

```lua
---Master toggle for the plugin
vim.g.u_todos = true

---Each group's id is its first comment.
---In this implementation we replace non-alphanumerics with "_"
---instead of properly hashing names, so there is a room for only
---one special group (`::` will have id "TODO___")
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

---Util function to get the ids.
local function get_sym(kind)
  return "TODO_" .. kind:gsub("[^%w]", "_")
end

---Setting highlight groups and defining signs
---which will appear in sidebar
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

---The query should either retrieve all comments,
---or capture TODO headers based on group
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

---Grouping autocmds and namespaces is very convenient
local augroup = vim.api.nvim_create_augroup("uTodos", { clear = false })
local ns = vim.api.nvim_create_namespace("uTodos")

---Treesitter is fast, but parsing queries still takes time,
---especially since we define whether language has `@comment`
---or `@line_comment` solemnly by trial and error,
---so lets cache the successful queries.
local queries = {}

---This is our main engine, which has frugal triggers.
---Yes, we will wait half a second to update highlights,
---but we won't slow down the editor.
vim.api.nvim_create_autocmd(
  { "CursorHold", "BufEnter", "InsertLeave", "BufWritePost" },
  {
    group = augroup,
    callback = function(args)
      ---Do nothing if plugin is disabled.
      if not vim.g.u_todos then
        return nil
      end

      ---Clear old highlights before making new ones
      vim.api.nvim_buf_clear_namespace(args.buf, ns, 0, -1)
      vim.fn.sign_unplace("uTodos", { buffer = args.buf })

      ---We need the language for caching.
      local ft = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(ft)

      ---Basically, if there is no TS support, go home.
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

      ---Get cache for lang
      local cache = queries[lang] or {}
      local ok, obj

      ---Assume language has @comment nodes
      local comment = "comment"
      cache[comment] = cache[comment] or {}
      if not cache[comment].gen then
        ok, obj = pcall(vim.treesitter.query.parse, lang, get_query(comment))
        cache[comment].gen = ok and obj or nil
      end

      ---If no @comment nodes, try @line_comment
      if not cache[comment].gen then
        comment = "line_comment"
        cache[comment] = cache[comment] or {}
        if not cache[comment].gen then
          ok, obj = pcall(vim.treesitter.query.parse, lang, get_query(comment))
          cache[comment].gen = ok and obj or nil
        end
      end

      ---If @comment or @line_comment, process as line comments
      if cache[comment].gen then
        local comments = {}
        for _, node, _, _ in
          ---@diagnostic disable-next-line: need-check-nil
          cache[comment].gen:iter_captures(root, args.buf, 0, -1)
        do
          local srow, scol, erow, ecol = node:range()
          comments[srow] = { srow, scol, erow, ecol }
        end

        ---Gather TODO headers as well
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
              ---Remove header lines from regular comments
              comments[srow] = nil
            end
          end
        end

        ---Highlight header and subsequent line comments
        ---as long as there is no break between them.
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

      ---Do roughly the same for block comments, but don't
      ---bleed highlights to subsequent comments.
      ---Blocks are self-contained.
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

      ---Update cache
      queries[lang] = cache
    end,
  }
)

---Toggle highlighting and clear once,
---since out autocmd will skip completely
---on u_todos = false
vim.keymap.set("n", "<Leader>tt", function()
  vim.g.u_todos = not vim.g.u_todos
  if not vim.g.u_todos then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    vim.fn.sign_unplace("uTodos", { buffer = 0 })
  end
end, { desc = "Toggle : Todos" })

---
---[[ Optional ]]
---

---Grep through all types of TODOS
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

---Grep through important TODOS (see groups table)
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
```
