return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  config = function()
    require("typst-preview").setup({
      invert_colors = "never",
      open_cmd = "brave %s",
    })

    vim.keymap.set("n", "<Leader>tp", function()
      vim.cmd("TypstPreviewToggle")
    end, { desc = "Toggle : Typst Preview" })
  end,
}
