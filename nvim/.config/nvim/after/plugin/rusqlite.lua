local embed = vim.treesitter.query.parse(
  "rust",
  [[
    (call_expression
      (field_expression
        (field_identifier) @id
        (#eq? @id "execute"))
      (arguments
        (string_literal
          (string_content) @sql)))
  ]]
)

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "rust", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function run_formatter(sql_text)
  local command = "sqlfmt -- " .. vim.fn.shellescape(sql_text)
  local result = vim.fn.system(command)
  if vim.v.shell_error ~= 0 then
    vim.notify("failed")
    return vim.split(sql_text, "\n")
  end

  local formatted_text = result:match("(.+)%s*$") or result
  return vim.split(formatted_text, "\n")
end

local format_sql = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "rust" then
    vim.notify("can only be used in rust")
    return
  end

  local root = get_root(bufnr)
  local changes = {}
  for id, node in embed:iter_captures(root, bufnr, 0, -1) do
    local name = embed.captures[id]
    if name == "sql" then
      local range = { node:range() }
      local indent = string.rep(" ", range[2])

      local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))
      for idx, line in ipairs(formatted) do
        formatted[idx] = indent .. line
      end

      table.insert(changes, 1, {
        start = range[1] + 1,
        final = range[3],
        formatted = formatted,
      })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(
      bufnr,
      change.start,
      change.final,
      false,
      change.formatted
    )
  end
end

vim.api.nvim_create_user_command("SqlMagic", function()
  format_sql()
end, {})
