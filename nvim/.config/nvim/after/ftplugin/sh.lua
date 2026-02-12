vim.keymap.set("n", "<Leader>.", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term source %")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Run Code" })

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("bashls")

-- local ns = vim.api.nvim_create_namespace("shellcheck")
-- local severities = {
--   error = vim.diagnostic.severity.ERROR,
--   warning = vim.diagnostic.severity.WARN,
--   info = vim.diagnostic.severity.INFO,
--   style = vim.diagnostic.severity.HINT,
-- }
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   callback = function(args)
--     local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
--     vim.system(
--       { "shellcheck", "--format", "json1", "-" },
--       { text = true, stdin = lines },
--       function(output)
--         -- apparently, in shellcheck:
--         -- 0 = clean, no lints
--         -- 1 = lints
--         -- 2+ = errors
--         if output.code > 1 then
--           vim.schedule(function()
--             vim.notify(
--               ("[shellcheck] failed with code %d:\n%s"):format(
--                 output.code,
--                 output.stderr
--               )
--             )
--           end)
--           return
--         end
--
--         -- just to make it clear what happened.
--         -- you might as well early-return on code 0 (no lints).
--         if not output.stdout then
--           vim.schedule(function()
--             vim.notify("[shellcheck] returned empty stdout")
--           end)
--           return
--         end
--
--         local result = vim.json.decode(output.stdout)
--         local diagnostics = {}
--         for _, item in ipairs(result.comments or {}) do
--           table.insert(diagnostics, {
--             lnum = item.line - 1,
--             col = item.column - 1,
--             end_lnum = item.endLine - 1,
--             end_col = item.endColumn - 1,
--             code = item.code,
--             source = "shellcheck",
--             user_data = {
--               lsp = {
--                 code = item.code,
--               },
--             },
--             severity = severities[item.level],
--             message = item.message,
--           })
--         end
--
--         vim.schedule(function()
--           -- I have no idea if you need to reset it
--           vim.diagnostic.reset(ns, args.buf)
--           -- nvim-lint uses .set() instead
--           vim.diagnostic.show(ns, args.buf, diagnostics)
--           -- I really don't script diagnostics that often
--         end)
--       end
--     )
--   end,
-- })
