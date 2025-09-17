-- TODO: Configure
return {
  "jake-stewart/multicursor.nvim",
  config = function()
    require("multicursor-nvim").setup()

    -- operator
    vim.keymap.set(
      { "n", "x" },
      "<Leader>m",
      require("multicursor-nvim").operator,
      { desc = "Cursor : Operator" }
    )
    vim.keymap.set("n", "<Leader>mx", function()
      require("multicursor-nvim").clearCursors()
    end, { desc = "Cursor : Clear" })
    vim.keymap.set("n", "<Esc>", function()
      require("multicursor-nvim").clearCursors()
      vim.cmd("nohlsearch")
    end, { desc = "Cursor : Clear" })

    -- add cursor visually
    vim.keymap.set({ "n", "x" }, "<Up>", function()
      require("multicursor-nvim").lineAddCursor(-1)
    end, { desc = "Cursor : Above" })
    vim.keymap.set({ "n", "x" }, "<M-Up>", function()
      require("multicursor-nvim").lineSkipCursor(-1)
    end, { desc = "Cursor : Skip Above" })
    vim.keymap.set({ "n", "x" }, "<Down>", function()
      require("multicursor-nvim").lineAddCursor(1)
    end, { desc = "Cursor : Below" })
    vim.keymap.set({ "n", "x" }, "<M-Down>", function()
      require("multicursor-nvim").lineSkipCursor(1)
    end, { desc = "Cursor : Skip Below" })

    -- add cursor by selection
    vim.keymap.set({ "n", "x" }, "<Left>", function()
      require("multicursor-nvim").matchAddCursor(-1)
    end, { desc = "Cursor : Match Previous" })
    vim.keymap.set({ "n", "x" }, "<M-Left>", function()
      require("multicursor-nvim").matchSkipCursor(-1)
    end, { desc = "Cursor : Skip Match Previous" })
    vim.keymap.set({ "n", "x" }, "<Right>", function()
      require("multicursor-nvim").matchAddCursor(1)
    end, { desc = "Cursor : Match Next" })
    vim.keymap.set({ "n", "x" }, "<M-Right>", function()
      require("multicursor-nvim").matchSkipCursor(1)
    end, { desc = "Cursor : Skip Match Next" })

    -- all matches/searches
    vim.keymap.set(
      { "n", "x" },
      "<Leader>mm",
      require("multicursor-nvim").matchAllAddCursors,
      { desc = "Cursor : Match All" }
    )
    vim.keymap.set(
      "n",
      "<Leader>ms",
      require("multicursor-nvim").searchAllAddCursors,
      { desc = "Cursor : Search All" }
    )
  end,
}
