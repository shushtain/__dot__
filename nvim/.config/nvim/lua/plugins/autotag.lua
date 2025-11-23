return {
  "windwp/nvim-ts-autotag",
  -- enabled = false,
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
      },
    })
  end,
}
