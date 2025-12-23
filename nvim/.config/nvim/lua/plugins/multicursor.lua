return {
  "jake-stewart/multicursor.nvim",
  -- enabled = false,
  config = function()
    require("multicursor-nvim").setup()

    vim.keymap.set("n", "<Esc><Esc>", function()
      require("multicursor-nvim").clearCursors()
      vim.cmd("nohlsearch")
    end, { desc = "Cursor : Clear" })

    --

    vim.keymap.set("n", "<Leader>mm", function()
      local ch = vim.fn.getcharstr()
      if ch ~= "\27" then
        require("multicursor-nvim").addCursor(ch)
      end
    end, { desc = "Cursor : Add" })

    vim.keymap.set("n", "<Leader>M", function()
      local ch = vim.fn.getcharstr()
      if ch ~= "\27" then
        require("multicursor-nvim").skipCursor(ch)
      end
    end, { desc = "Cursor : Skip" })

    --

    vim.keymap.set({ "n", "x" }, "<Leader>ma", function()
      require("multicursor-nvim").matchAllAddCursors()
    end, { desc = "Cursor : Match All" })

    vim.keymap.set("n", "<Leader>ms", function()
      require("multicursor-nvim").searchAllAddCursors()
    end, { desc = "Cursor : Search All" })

    --

    vim.keymap.set("x", "<Leader>mt", function()
      require("multicursor-nvim").transposeCursors(1)
    end, { desc = "Cursor : Transpose" })

    vim.keymap.set("x", "<Leader>mT", function()
      require("multicursor-nvim").transposeCursors(-1)
    end, { desc = "Cursor : Transpose Back" })

    --

    vim.keymap.set({ "n", "x" }, "<Leader>m<C-a>", function()
      require("multicursor-nvim").sequenceIncrement()
    end, { desc = "Cursor : Increment" })

    vim.keymap.set({ "n", "x" }, "<Leader>m<C-x>", function()
      require("multicursor-nvim").sequenceDecrement()
    end, { desc = "Cursor : Decrement" })

    --

    vim.keymap.set({ "n", "x" }, "<Up>", function()
      require("multicursor-nvim").lineAddCursor(-1)
    end, { desc = "Cursor : Line Above" })

    vim.keymap.set({ "n", "x" }, "<M-Up>", function()
      require("multicursor-nvim").lineSkipCursor(-1)
    end, { desc = "Cursor : Skip Above" })

    vim.keymap.set({ "n", "x" }, "<Down>", function()
      require("multicursor-nvim").lineAddCursor(1)
    end, { desc = "Cursor : Line Below" })

    vim.keymap.set({ "n", "x" }, "<M-Down>", function()
      require("multicursor-nvim").lineSkipCursor(1)
    end, { desc = "Cursor : Skip Below" })

    --

    vim.keymap.set({ "n", "x" }, "<Left>", function()
      require("multicursor-nvim").matchAddCursor(-1)
    end, { desc = "Cursor : Match Prev" })

    vim.keymap.set({ "n", "x" }, "<M-Left>", function()
      require("multicursor-nvim").matchSkipCursor(-1)
    end, { desc = "Cursor : Skip Prev" })

    vim.keymap.set({ "n", "x" }, "<Right>", function()
      require("multicursor-nvim").matchAddCursor(1)
    end, { desc = "Cursor : Match Next" })

    vim.keymap.set({ "n", "x" }, "<M-Right>", function()
      require("multicursor-nvim").matchSkipCursor(1)
    end, { desc = "Cursor : Skip Next" })

    --

    vim.keymap.set("n", "<C-LeftMouse>", function()
      require("multicursor-nvim").handleMouse()
    end)

    vim.keymap.set("n", "<C-LeftDrag>", function()
      require("multicursor-nvim").handleMouseDrag()
    end)

    vim.keymap.set("n", "<C-LeftRelease>", function()
      require("multicursor-nvim").handleMouseRelease()
    end)
  end,
}
