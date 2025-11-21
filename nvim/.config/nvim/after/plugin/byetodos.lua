-- :: Match all comments and gather by idx.
-- :: Match each comment type headers, gather.
-- :: Exclude each header of each type from all comments.
-- :: Sort all_comments.
-- :: Iterate through headers +1 until there is a gap in all_comments.
-- :: Pop assigned comments, not to iterate through them anymore.

if true then
  return nil
end

local function id(comment, is_header)
  return "@todo_" .. comment .. (is_header and "_header" or "_body")
end

-- ; (((line_comment) @todo_header
-- ;   (#match? @todo "TODO:"))
-- ;   (line_comment)* @todo_body
-- (#not-match? @todo_body "TODO:"))
local function comment_query(query, comment)
  local header = id(comment, true)
  local body = id(comment, false)
  return "((("
    .. query
    .. ")"
    .. header
    .. "(#match?)"
    .. header
    .. '"'
    .. comment
    .. ':"))('
    .. query
    .. ")*"
    .. body
    .. "(#not-match?"
    .. body
    .. '"'
    .. comment
    .. ':"))'
  -- return "(("
  --   .. query
  --   .. ")+ "
  --   .. "@_todo"
  --   .. "(#any-match? "
  --   .. "@_todo"
  --   .. ' "'
  --   .. comment
  --   .. ':")) '
  --   .. id
end

local comments = {
  ["FIX"] = "#FF4A20",
  ["WARN"] = "#FF8000",
  ["HACK"] = "#FF8000",
  ["NOTE"] = "#81AE64",
  ["FAIL"] = "#47DDAA",
  ["PASS"] = "#47DDAA",
  ["TEST"] = "#47DDAA",
  ["TODO"] = "#1AB9D1",
  ["PERF"] = "#B575FF",
  -- [":"] = "#FF6299",
}

for comment, color in pairs(comments) do
  local kind = comment:gsub("[^%w]", "_")
  vim.api.nvim_set_hl(0, "HiTodos" .. kind, { fg = color })
  vim.fn.sign_define(
    "HiTodos" .. kind,
    { text = "⧺", texthl = "HiTodos" .. kind }
  )
end

local queries = {}

local group = vim.api.nvim_create_augroup("uHiTodos", { clear = true })
local ns = vim.api.nvim_create_namespace("uHiTodos")

vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "InsertLeave" }, {
  group = group,
  callback = function(args)
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    vim.fn.sign_unplace("HiTodos")

    local filetype = vim.bo[args.buf].filetype
    local language = vim.treesitter.language.get_lang(filetype) or filetype
    if not language or language == "" then
      return nil
    end

    for _, comment in ipairs(vim.tbl_keys(comments)) do
      queries[comment] = {}

      local template = comment_query("line_comment", comment)
      local ok, query = pcall(vim.treesitter.query.parse, language, template)
      if ok then
        table.insert(queries[comment], 1, query)
      end

      template = comment_query("comment", comment)
      ok, query = pcall(vim.treesitter.query.parse, language, template)
      if ok then
        table.insert(queries[comment], 1, query)
      end
    end

    local parser = vim.treesitter.get_parser(args.buf, language, {})
    local root = parser:parse()[1]:root()

    for comment, color in pairs(comments) do
      -- local captures = {}
      for _, query in ipairs(vim.tbl_values(queries[comment])) do
        for id, node, meta, match in query:iter_captures(root, args.buf, 0, -1) do
          local name = query.captures[id]
          if name == id(comment, true) then
            -- srow, scol, erow, ecol
            local range = { node:range() }
            vim.fn.sign_place(
              0,
              "HiTodos",
              "HiTodos" .. comment,
              "%",
              { lnum = range[1] + 1, priority = 8 }
            )
            vim.api.nvim_buf_set_extmark(0, ns, range[1], range[2], {
              end_col = range[4],
              hl_group = "HiTodos" .. comment,
            })

            -- table.insert(captures, 1, range)
            -- print(vim.inspect({ text, range }))
          end
        end
      end
    end
  end,
})
