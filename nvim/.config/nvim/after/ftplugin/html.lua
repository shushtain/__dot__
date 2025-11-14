vim.bo.shiftwidth = 2
vim.lsp.enable("html")
vim.lsp.enable("emmet_language_server")

-- local group = vim.api.nvim_create_augroup("uHtmlTera", { clear = true })
-- local ns = vim.api.nvim_create_namespace("uHtmlTera")
-- vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "InsertLeave" }, {
--   group = group,
--   callback = function()
--     vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--     for row, line in ipairs(lines) do
--       local start = 1
--       while true do
--         local spos, epos = line:find("{%%?{?#?[^}]*#?%%?}?}", start, false)
--         if not spos or not epos then
--           break
--         end
--         vim.api.nvim_buf_set_extmark(
--           0,
--           ns,
--           row - 1,
--           spos - 1,
--           { end_col = epos, hl_group = "@error" }
--         )
--         start = epos + 1
--       end
--     end
--   end,
-- })
