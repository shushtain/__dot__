-- vim.bo.expandtab = false

vim.keymap.set("n", "<Leader>ga", function()
  vim.cmd('normal! "hyl')
  local ch = vim.fn.getreg("h")
  local hex = string.format("U%04x", vim.fn.char2nr(ch))
  vim.fn.setreg("h", hex)
  vim.cmd('normal! v"hp')
end, { desc = "Convert char to XKB Unicode hex" })

local augroup = vim.api.nvim_create_augroup("uXkbSymbols", { clear = false })
local ns = vim.api.nvim_create_namespace("uXkbSymbols")
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd(
  { "CursorHold", "BufEnter", "InsertLeave", "BufWritePost" },
  {
    buffer = buf,
    group = augroup,
    callback = function(args)
      vim.api.nvim_buf_clear_namespace(args.buf, ns, 0, -1)
      local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
      for i, line in ipairs(lines) do
        local symbols = {}
        for hex in line:gmatch("U(%x%x%x%x+)") do
          local code = tonumber(hex, 16)
          if code then
            if code == 160 then
              code = 9251
            end
            table.insert(symbols, code and vim.fn.nr2char(code) or "�")
          end
        end
        if #symbols > 0 then
          local display = table.concat(symbols, " │ ")
          vim.api.nvim_buf_set_extmark(args.buf, ns, i - 1, 2, {
            virt_text = { { " " .. display, "DiagnosticVirtualTextHint" } },
            -- virt_text_pos = "eol",
            virt_text_win_col = 60,
            hl_mode = "combine",
          })
        end
      end
    end,
  }
)
