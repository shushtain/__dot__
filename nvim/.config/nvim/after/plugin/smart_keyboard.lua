local group = vim.api.nvim_create_augroup("uSmartKeyboard", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function()
    if vim.g.smart_keyboard then
      vim.fn.system("hyprctl switchxkblayout at-translated-set-2-keyboard 1")
    end
  end,
  desc = "Switch to an additional layout",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  callback = function()
    if vim.g.smart_keyboard then
      vim.fn.system("hyprctl switchxkblayout at-translated-set-2-keyboard 0")
    end
  end,
  desc = "Switch to the primary layout",
})

vim.keymap.set("n", "<Leader>tK", function()
  if vim.g.smart_keyboard then
    vim.api.nvim_set_hl(0, "CursorLine", { bg = vim.g.smart_keyboard })
    vim.g.smart_keyboard = nil
  else
    vim.g.smart_keyboard = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg
    vim.api.nvim_set_hl(
      0,
      "CursorLine",
      { bg = vim.g.farba.colors.general.yellow.v15 }
    )
  end
end, { noremap = true, desc = "Toggle : Smart Keyboard" })
