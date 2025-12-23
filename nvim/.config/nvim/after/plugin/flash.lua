local ns = vim.api.nvim_create_namespace("u_flash")
local labels = vim.split("hjkl;asdfgrueiwotyqpvbcnxmz", "")

vim.api.nvim_set_hl(0, "uFlash", {
  fg = vim.g.farba.palette.general.gray.v10,
  bg = vim.g.farba.palette.status.yellow.v70,
  bold = true,
})

local function flash()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local ch1 = vim.fn.getcharstr()
  local ch2 = vim.fn.getcharstr()

  local srow, erow = vim.fn.line("w0"), vim.fn.line("w$")
  local lines = vim.api.nvim_buf_get_lines(buf, srow - 1, erow, false)

  local label_i = 1
  local extmarks = {}

  local pattern = ch1 .. ch2
  local cased = pattern ~= pattern:lower()

  local exhausted = false
  for line_i, text in ipairs(lines) do
    if exhausted then
      break
    end
    if not cased then
      text = text:lower()
    end
    if vim.fn.foldclosed(line_i + srow - 1) == -1 then
      for col = 1, #text do
        if exhausted then
          break
        end
        if text:sub(col, col + 1) == pattern and label_i <= #labels then
          local overlay = labels[label_i]
          local line = srow + line_i - 2
          vim.api.nvim_buf_set_extmark(buf, ns, line, col + 1, {
            virt_text = { { overlay, "uFlash" } },
            virt_text_pos = "overlay",
            hl_mode = "replace",
          })
          extmarks[overlay] = { line, col - 1 }
          label_i = label_i + 1
          exhausted = label_i > #labels
        end
      end
    end
  end

  if vim.tbl_count(extmarks) == 0 then
    vim.notify("no matches", vim.log.levels.WARN)
    return
  end

  vim.schedule(function()
    local next = vim.fn.getcharstr()
    local pos = extmarks[next]
    if pos then
      vim.cmd("normal! m'")
      vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
    end
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  end)
end

vim.keymap.set({ "n", "x" }, "<M-f>", flash, { desc = "Flash" })
