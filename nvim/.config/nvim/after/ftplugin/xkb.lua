-- XXX:
vim.lsp.enable("ub0fa")
-- vim.bo.expandtab = false

-- vim.keymap.set("n", "<Leader>ga", function()
--   vim.cmd('normal! "qyiw')
--   local ch = vim.fn.getreg("q")
--   local hex = string.format("U%04x", vim.fn.char2nr(ch))
--   vim.fn.setreg("q", hex)
--   vim.cmd('normal! viw"qp')
-- end, { desc = "Convert char to XKB Unicode hex" })

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
            local char = vim.fn.nr2char(code)
            if code == 160 then
              char = "␣"
            elseif code >= 0x0300 and code <= 0x036f then
              char = "◌" .. char
            end
            table.insert(symbols, char ~= "" and char or "�")
          else
            table.insert(symbols, "�")
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
