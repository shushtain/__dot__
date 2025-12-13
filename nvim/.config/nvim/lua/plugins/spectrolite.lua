return {
  "shushtain/spectrolite.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/spectrolite.nvim"),
  dev = true,
  config = function()
    require("spectrolite").setup({
      hexa = { uppercase = true },
    })

    -- #CC0000FF
    -- #CC0000
    -- rgba(255 180 0 / 1)
    -- rgb(255 180 0)
    -- hsla(90 90 50 / 1)
    -- hsl(90 90 50)
    -- hxla(180 149 50 / 1)
    -- hxl(180 150 50)

    vim.keymap.set({ "n", "x" }, "<Leader>tc", function()
      require("spectrolite.highlighter").toggle()
    end, { desc = "Toggle : Colorize" })

    vim.keymap.set(
      { "n", "x" },
      "<Leader>cc",
      "<Cmd> Spectrolite <CR>",
      { desc = "Spectrolite : Select" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>ch",
      "<Cmd> Spectrolite hex <CR>",
      { desc = "Spectrolite : HEX" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cr",
      "<Cmd> Spectrolite rgb <CR>",
      { desc = "Spectrolite : RGB" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cs",
      "<Cmd> Spectrolite hsl <CR>",
      { desc = "Spectrolite : HSL" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cx",
      "<Cmd> Spectrolite hxl <CR>",
      { desc = "Spectrolite : HXL" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cH",
      "<Cmd> Spectrolite hexa <CR>",
      { desc = "Spectrolite : HEX" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cR",
      "<Cmd> Spectrolite rgba <CR>",
      { desc = "Spectrolite : RGB" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cS",
      "<Cmd> Spectrolite hsla <CR>",
      { desc = "Spectrolite : HSL" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<Leader>cX",
      "<Cmd> Spectrolite hxla <CR>",
      { desc = "Spectrolite : HXL" }
    )

    vim.keymap.set({ "n", "x" }, "<Leader>ci", function()
      local sp = require("spectrolite")
      local str, sel = assert(sp.read())
      local color, model = assert(sp.parse(str))

      local uni = "hsl"
      if model[#model] == "a" then
        uni = "hsla"
      end

      local normal = sp.normalize(model, color)
      local hsl = sp.denormalize(uni, normal)

      hsl.l = 100 - hsl.l

      normal = sp.normalize(uni, hsl)
      color = sp.denormalize(model, normal)
      color = sp.format(model, color)
      str = sp.print(model, color)
      sp.write(sel, str)
    end, { desc = "Spectrolite : Invert" })

    vim.keymap.set({ "n", "x" }, "<Leader>cg", function()
      local sp = require("spectrolite")
      local str, sel = assert(sp.read())
      local color, model = assert(sp.parse(str))

      local uni = "hxl"
      if model[#model] == "a" then
        uni = "hxla"
      end

      local normal = sp.normalize(model, color)
      local hxl = sp.denormalize(uni, normal)

      hxl.x = 0

      normal = sp.normalize(uni, hxl)
      color = sp.denormalize(model, normal)
      color = sp.format(model, color)
      str = sp.print(model, color)
      sp.write(sel, str)
    end, { desc = "Spectrolite : Grayscale" })

    vim.keymap.set({ "n", "x" }, "<Leader>cu", function()
      local sp = require("spectrolite")
      local str, sel = assert(sp.read())
      local color, model = assert(sp.parse(str))

      local uni = "hsl"
      if model[#model] == "a" then
        uni = "hsla"
      end

      local normal = sp.normalize(model, color)

      normal.rn = 1 - normal.rn
      normal.gn = 1 - normal.gn
      normal.bn = 1 - normal.bn

      local hsl = sp.denormalize(uni, normal)

      hsl.l = 100 - hsl.l

      normal = sp.normalize(uni, hsl)
      color = sp.denormalize(model, normal)
      color = sp.format(model, color)
      str = sp.print(model, color)
      sp.write(sel, str)
    end, { desc = "Spectrolite : Antihue" })

    vim.keymap.set({ "n", "x" }, "<Leader>c\\", function()
      local sp = require("spectrolite")
      local str, _ = assert(sp.read())
      local color, model = assert(sp.parse(str))
      local normal = sp.normalize(model, color)
      local output = sp.denormalize(model, normal)
      output = sp.format(model, color)
      vim.print({ model, color, normal, output })
    end, { desc = "Spectrolite : Debug" })
  end,
}
