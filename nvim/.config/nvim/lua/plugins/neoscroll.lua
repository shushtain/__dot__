return {
  "karb94/neoscroll.nvim",
  enabled = false,
  config = function()
    require("neoscroll").setup({
      hide_cursor = false,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = false,
      duration_multiplier = 0.5,
      easing = "linear",
    })
  end,
}
