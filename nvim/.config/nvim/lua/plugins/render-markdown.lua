return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  -- cmd = { "RenderMarkdown" },
  -- keys = {
  --   "<Leader>tm",
  --   "<Leader>tM",
  -- },
  config = function()
    require("render-markdown").setup({
      enabled = false,
      render_modes = { "n", "c", "t" },
      debounce = 100,
      file_types = { "markdown" },
      preset = "none",
      completions = {
        lsp = {
          enabled = true,
        },
      },
      anti_conceal = {
        enabled = true,
        disabled_modes = false,
        above = 0,
        below = 0,
        ignore = {
          code_background = true,
          indent = true,
          sign = true,
          virtual_lines = true,
        },
      },

      heading = {
        enabled = false,
      },

      paragraph = {
        enabled = false,
      },

      code = {
        enabled = true,
        sign = false,
        conceal_delimiters = true,
        language = false,
        width = "block",
        min_width = 40,
        left_pad = 1,
        right_pad = 1,
        -- above = " ",
        -- below = " ",
        border = "thick",
        highlight = "CursorLine",
      },

      dash = {
        enabled = true,
        -- icon = "∙",
      },

      document = {
        enabled = true,
      },

      bullet = {
        enabled = true,
        icons = { "•" },
        highlight = "@markup.list",
      },

      checkbox = {
        enabled = true,
        bullet = false,
        right_pad = 1,
        unchecked = {
          icon = "□",
          highlight = "@markup.list.unchecked",
        },
        checked = {
          icon = "■",
          highlight = "@markup.list.checked",
        },
      },

      quote = {
        enabled = true,
        icon = "│",
      },

      pipe_table = {
        enabled = true,
        preset = "none",
        cell = "padded",
        padding = 1,
        min_width = 0,
        border_enabled = false,
      },

      link = {
        enabled = true,
        footnote = {
          enabled = true,
          superscript = true,
          prefix = "",
          suffix = "",
        },
        image = "󰋩 ",
        email = "",
        hyperlink = "",
        highlight = "@markup.link",
        wiki = {
          icon = " ",
          highlight = "@lsp.type.class.markdown",
        },
      },

      sign = {
        enabled = false,
        highlight = "DiagnosticSignHint",
      },

      inline_highlight = {
        enabled = false,
      },

      indent = {
        enabled = false,
        per_level = 2,
        skip_level = 1,
        skip_heading = false,
        icon = "",
      },

      html = {
        enabled = true,
        comment = {
          conceal = true,
        },
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>tm",
      "<Cmd> RenderMarkdown toggle <CR>",
      { desc = "Toggle : Markdown All" }
    )
    vim.keymap.set(
      "n",
      "<Leader>tM",
      "<Cmd> RenderMarkdown buf_toggle <CR>",
      { desc = "Toggle : Markdown" }
    )
  end,
}
