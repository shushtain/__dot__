return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  config = function()
    require("typst-preview").setup({
      invert_colors = "never",
      open_cmd = "brave --new-window %s",
      -- port = 8081,
    })
  end,
}
