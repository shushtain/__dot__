return {
  "shushtain/labradorite.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/labradorite.nvim"),
  dev = true,
  config = function()
    require("labradorite").setup({
      autostart = false,
    })

    vim.keymap.set({ "n", "v" }, "<Leader>tc", function()
      require("labradorite").toggle()
    end, { desc = "Toggle : Labradorite" })

    -- #CC0000FF
    -- #CC0000
    -- rgba(255 180 0 / 1)
    -- rgb(255 180 0)
    -- hsla(90 90 50 / 1)
    -- hsl(90 90 50)
    -- hxla(180 150 50 / 1)
    -- hxl(180 150 50)
  end,
}
