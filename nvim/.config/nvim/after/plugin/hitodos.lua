-- if true then
--   return nil
-- end

local group = vim.api.nvim_create_augroup("uHiTodos", { clear = true })
local ns = vim.api.nvim_create_namespace("uHiTodos")

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
  [":"] = "#FF6299",
}

-- FIX:   𜱃𜱃𜱃𜱃𜱃
-- WARN:  𜱃𜱃𜱃𜱃𜱃
-- HACK:  𜱃𜱃𜱃𜱃𜱃
-- NOTE:  𜱃𜱃𜱃𜱃𜱃
-- TEST:  𜱃𜱃𜱃𜱃𜱃
-- TODO:  𜱃𜱃𜱃𜱃𜱃
-- PERF:  𜱃𜱃𜱃𜱃𜱃
-- :::::  𜱃𜱃𜱃𜱃𜱃

for comment, color in pairs(comments) do
  local kind = comment:gsub("[^%w]", "_")
  vim.api.nvim_set_hl(0, "HiTodos" .. kind, { fg = color })
  vim.fn.sign_define(
    "HiTodos" .. kind,
    { text = "⧺", texthl = "HiTodos" .. kind }
  )
end

vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "InsertLeave" }, {
  group = group,
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    vim.fn.sign_unplace("HiTodos")

    local pattern = vim.bo.commentstring
    if not pattern or #pattern == 0 then
      pattern = "# "
    end
    pattern = pattern:gsub("%%s.*", "")

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for row, line in ipairs(lines) do
      local spos, epos = line:find(pattern, 1, true)
      if spos then
        for comment, _ in pairs(comments) do
          spos, epos = line:find(pattern .. comment .. ":", 1, true)
          if spos and epos then
            local kind = comment:gsub("[^%w]", "_")
            vim.fn.sign_place(
              0,
              "HiTodos",
              "HiTodos" .. kind,
              "%",
              { lnum = row, priority = 8 }
            )

            vim.api.nvim_buf_set_extmark(0, ns, row - 1, spos + #pattern - 1, {
              end_col = #line,
              hl_group = "HiTodos" .. kind,
            })
            break
          end
        end
      end
    end
  end,
})
