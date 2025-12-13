return {
  "windwp/nvim-ts-autotag",
  enabled = false,
  config = function()
    ---@diagnostic disable-next-line: param-type-mismatch, missing-fields
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
      },
    })
  end,
}
