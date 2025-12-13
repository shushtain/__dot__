return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = false,
  branch = "main",
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    --[[ SELECT ]]

    vim.keymap.set({ "x", "o" }, "aj", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@parameter.outer",
        "textobjects"
      )
    end, { desc = "parameter" })
    vim.keymap.set({ "x", "o" }, "ij", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@parameter.inner",
        "textobjects"
      )
    end, { desc = "parameter" })

    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@function.outer",
        "textobjects"
      )
    end, { desc = "function" })
    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@function.inner",
        "textobjects"
      )
    end, { desc = "function" })

    vim.keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@class.outer",
        "textobjects"
      )
    end, { desc = "class" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@class.inner",
        "textobjects"
      )
    end, { desc = "class" })

    vim.keymap.set({ "x", "o" }, "ao", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@loop.outer",
        "textobjects"
      )
    end, { desc = "loop" })
    vim.keymap.set({ "x", "o" }, "io", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@loop.inner",
        "textobjects"
      )
    end, { desc = "loop" })

    vim.keymap.set({ "x", "o" }, "ai", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@conditional.outer",
        "textobjects"
      )
    end, { desc = "conditional" })
    vim.keymap.set({ "x", "o" }, "ii", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@conditional.inner",
        "textobjects"
      )
    end, { desc = "conditional" })

    vim.keymap.set({ "x", "o" }, "am", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@call.outer",
        "textobjects"
      )
    end, { desc = "call" })
    vim.keymap.set({ "x", "o" }, "im", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@call.inner",
        "textobjects"
      )
    end, { desc = "call" })

    --[[ SWAP ]]
    vim.keymap.set("n", "<Leader>xn", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end, { desc = "Swap : Parameters" })
    vim.keymap.set("n", "<Leader>xp", function()
      require("nvim-treesitter-textobjects.swap").swap_previous(
        "@parameter.inner"
      )
    end, { desc = "Swap : Parameters Back" })

    vim.keymap.set("n", "<Leader>xf", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@function.outer")
    end, { desc = "Swap : Functions" })
    vim.keymap.set("n", "<Leader>xF", function()
      require("nvim-treesitter-textobjects.swap").swap_previous(
        "@function.outer"
      )
    end, { desc = "Swap : Functions Back" })

    vim.keymap.set("n", "<Leader>xm", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@call.outer")
    end, { desc = "Swap : Calls" })
    vim.keymap.set("n", "<Leader>xM", function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@call.outer")
    end, { desc = "Swap : Calls Back" })

    --[[ MOVE ]]

    vim.keymap.set({ "n", "x", "o" }, "]p", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@parameter.inner",
        "textobjects"
      )
    end, { desc = "Next : Parameter" })
    vim.keymap.set({ "n", "x", "o" }, "]P", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@parameter.inner",
        "textobjects"
      )
    end, { desc = "Next : Parameter End" })
    vim.keymap.set({ "n", "x", "o" }, "[p", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@parameter.inner",
        "textobjects"
      )
    end, { desc = "Prev : Parameter" })
    vim.keymap.set({ "n", "x", "o" }, "[P", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@parameter.inner",
        "textobjects"
      )
    end, { desc = "Prev : Parameter End" })

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@function.outer",
        "textobjects"
      )
    end, { desc = "Next : Function" })
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@function.outer",
        "textobjects"
      )
    end, { desc = "Next : Function End" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@function.outer",
        "textobjects"
      )
    end, { desc = "Prev : Function" })
    vim.keymap.set({ "n", "x", "o" }, "[F", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@function.outer",
        "textobjects"
      )
    end, { desc = "Prev : Function End" })

    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@class.outer",
        "textobjects"
      )
    end, { desc = "Next : Class" })
    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@class.outer",
        "textobjects"
      )
    end, { desc = "Next : Class End" })
    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@class.outer",
        "textobjects"
      )
    end, { desc = "Prev : Class" })
    vim.keymap.set({ "n", "x", "o" }, "[C", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@class.outer",
        "textobjects"
      )
    end, { desc = "Prev : Class End" })

    vim.keymap.set({ "n", "x", "o" }, "]o", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@loop.outer",
        "textobjects"
      )
    end, { desc = "Next : Loop" })
    vim.keymap.set({ "n", "x", "o" }, "]O", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@loop.outer",
        "textobjects"
      )
    end, { desc = "Next : Loop End" })
    vim.keymap.set({ "n", "x", "o" }, "[o", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@loop.outer",
        "textobjects"
      )
    end, { desc = "Prev : Loop" })
    vim.keymap.set({ "n", "x", "o" }, "[O", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@loop.outer",
        "textobjects"
      )
    end, { desc = "Prev : Loop End" })

    vim.keymap.set({ "n", "x", "o" }, "]i", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@conditional.outer",
        "textobjects"
      )
    end, { desc = "Next : Conditional" })
    vim.keymap.set({ "n", "x", "o" }, "]I", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@conditional.outer",
        "textobjects"
      )
    end, { desc = "Next : Conditional End" })
    vim.keymap.set({ "n", "x", "o" }, "[i", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@conditional.outer",
        "textobjects"
      )
    end, { desc = "Prev : Conditional" })
    vim.keymap.set({ "n", "x", "o" }, "[I", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@conditional.outer",
        "textobjects"
      )
    end, { desc = "Prev : Conditional End" })

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      require("nvim-treesitter-textobjects.move").goto_next_start(
        "@call.outer",
        "textobjects"
      )
    end, { desc = "Next : Call" })
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      require("nvim-treesitter-textobjects.move").goto_next_end(
        "@call.outer",
        "textobjects"
      )
    end, { desc = "Next : Call End" })
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start(
        "@call.outer",
        "textobjects"
      )
    end, { desc = "Prev : Call" })
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end(
        "@call.outer",
        "textobjects"
      )
    end, { desc = "Prev : Call End" })

    --[[ REPEAT ]]

    -- vim.keymap.set(
    --   { "n", "x", "o" },
    --   ";",
    --   require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next,
    --   { expr = true, desc = "Repeat Move" }
    -- )
    -- vim.keymap.set(
    --   { "n", "x", "o" },
    --   ",",
    --   require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous,
    --   { expr = true, desc = "Repeat Move Back" }
    -- )

    vim.keymap.set(
      { "n", "x", "o" },
      "f",
      require("nvim-treesitter-textobjects.repeatable_move").builtin_f_expr,
      { expr = true }
    )
    vim.keymap.set(
      { "n", "x", "o" },
      "F",
      require("nvim-treesitter-textobjects.repeatable_move").builtin_F_expr,
      { expr = true }
    )
    vim.keymap.set(
      { "n", "x", "o" },
      "t",
      require("nvim-treesitter-textobjects.repeatable_move").builtin_t_expr,
      { expr = true }
    )
    vim.keymap.set(
      { "n", "x", "o" },
      "T",
      require("nvim-treesitter-textobjects.repeatable_move").builtin_T_expr,
      { expr = true }
    )
  end,
}
