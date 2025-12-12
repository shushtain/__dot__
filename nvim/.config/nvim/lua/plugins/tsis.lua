return {
  "shushtain/nvim-treesitter-incremental-selection",
  enabled = false,
  dir = vim.fn.expand("~/box/tsis.nvim"),
  dev = true,
  config = function()
    require("nvim-treesitter-incremental-selection").setup({
      ignore_injections = false,
      loop_siblings = true,
      fallback = true,
      quiet = true,
    })

    vim.keymap.set(
      "n",
      "<CR>",
      require("nvim-treesitter-incremental-selection").init_selection
    )
    vim.keymap.set(
      "v",
      "<CR>",
      require("nvim-treesitter-incremental-selection").increment_node
    )
    vim.keymap.set(
      "v",
      "<S-CR>",
      require("nvim-treesitter-incremental-selection").decrement_node
    )

    vim.keymap.set(
      "v",
      "<Tab>",
      require("nvim-treesitter-incremental-selection").next_sibling
    )
    vim.keymap.set(
      "v",
      "<S-Tab>",
      require("nvim-treesitter-incremental-selection").prev_sibling
    )
    vim.keymap.set(
      "v",
      "<M-CR>",
      require("nvim-treesitter-incremental-selection").child
    )
    vim.keymap.set("v", "<M-BS>", function()
      require("nvim-treesitter-incremental-selection").child(-1)
    end)
  end,
}
