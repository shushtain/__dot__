return {
  "shushtain/incselect.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/incselect.nvim"),
  dev = true,
  config = function()
    vim.keymap.set("n", "<CR>", function()
      if not require("incselect").init() then
        vim.cmd("normal! viW")
      end
    end)
    vim.keymap.set("x", "<CR>", require("incselect").parent)
    vim.keymap.set("x", "<S-CR>", require("incselect").child)
    vim.keymap.set("x", "<Tab>", require("incselect").next)
    vim.keymap.set("x", "<S-Tab>", require("incselect").prev)
    vim.keymap.set("x", "<M-CR>", require("incselect").undo)
  end,
}
