return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  dependencies = {},
  config = function()
    require("fzf-lua").setup({
      keymap = {
        builtin = {
          ["<M-Esc>"] = "hide",
          ["<M-/>"] = "toggle-help",
          ["<M-=>"] = "toggle-fullscreen",
          ["<M-w>"] = "toggle-preview-wrap",
          ["<M-p>"] = "toggle-preview",
          ["<M-r>"] = "toggle-preview-cw",
          ["<M-o>"] = "preview-reset",
          ["<M-f>"] = "preview-page-down",
          ["<M-b>"] = "preview-page-up",
          ["<M-d>"] = "preview-down",
          ["<M-u>"] = "preview-up",
        },
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["alt-j"] = "down",
          ["alt-k"] = "up",
          ["alt-g"] = "first",
          ["alt-G"] = "last",
          ["alt-w"] = "toggle-preview-wrap",
          ["alt-p"] = "toggle-preview",
          ["alt-f"] = "preview-page-down",
          ["alt-b"] = "preview-page-up",
        },
      },
      actions = {
        files = {
          ["enter"] = require("fzf-lua").actions.file_edit_or_qf,
          ["alt-backspace"] = require("fzf-lua").actions.file_split,
          ["alt-enter"] = require("fzf-lua").actions.file_vsplit,
          ["alt-q"] = require("fzf-lua").actions.file_sel_to_qf,
          ["alt-l"] = require("fzf-lua").actions.file_sel_to_ll,
          ["alt-t"] = require("trouble.sources.fzf").actions.open,
          ["alt-\\"] = require("fzf-lua").actions.toggle_ignore,
          ["alt-."] = require("fzf-lua").actions.toggle_hidden,
          ["alt-,"] = require("fzf-lua").actions.toggle_follow,
        },
      },

      -- [[ MODULES ]]
      defaults = {
        file_icons = false,
        -- git_icons = true,
        -- no_header = true,
        cwd_header = false,
        no_header_i = true,
        silent = true,
        prompt = "> ",
        rg_opts = "--line-number --no-heading --color=always --smart-case --max-columns=4096 -e --field-match-separator=':' --colors=path:fg:black --colors=path:style:intense --colors=line:fg:black --colors=line:style:intense --colors=column:fg:black --colors=column:style:intense --colors=match:fg:green --colors=match:style:nobold --colors=match:style:intense",
      },
      files = {
        formatter = "path.filename_first",
        cwd_prompt = false,
        hidden = true,
      },
      grep = {
        hidden = true,
        path_shorten = 3,
        -- formatter = "path.dirname_first",
      },
      lsp = {
        code_actions = {
          previewer = "codeaction_native",
        },
        symbols = {
          child_prefix = "  ",
          symbol_style = 2,
          symbol_fmt = function(s, _)
            return s
          end,
          -- symbol_icons = {
          --   File = "󰈙",
          --   Module = "",
          --   Namespace = "󰦮",
          --   Package = "",
          --   Class = "󰆧",
          --   Method = "󰊕",
          --   Property = "",
          --   Field = "",
          --   Constructor = "",
          --   Enum = "",
          --   Interface = "",
          --   Function = "󰊕",
          --   Variable = "󰀫",
          --   Constant = "󰏿",
          --   String = "",
          --   Number = "󰎠",
          --   Boolean = "󰨙",
          --   Array = "󱡠",
          --   Object = "",
          --   Key = "󰌋",
          --   Null = "󰟢",
          --   EnumMember = "",
          --   Struct = "󰆼",
          --   Event = "",
          --   Operator = "󰆕",
          --   TypeParameter = "󰗴",
          -- },
        },
      },

      -- [[ STYLE ]]
      winopts = {
        border = "solid",
        backdrop = 100,
        title_flags = false,
        treesitter = {
          enabled = false,
        },
        preview = {
          -- hidden = true,
          vertical = "down:45%",
          horizontal = "right:50%",
          layout = "flex",
          border = "solid",
          wrap = false,
          scrollbar = "float",
        },
      },
      hls = {
        normal = "NormalFloat",
        border = "FloatBorder",
        -- title = "FloatTitle",
        title = "NoneFloat",
        title_flags = "FloatFooter",
        preview_normal = "NormalFloat",
        preview_border = "FloatBorder",
        -- preview_title = "FloatTitle",
        preview_title = "NoneFloat",
        scrollborder_e = "PmenuSbar",
        scrollborder_f = "PmenuThumb",
        live_prompt = "NormalFloat",
        live_sym = "Constant",
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--info"] = "inline-right",
        ["--height"] = "100%",
        ["--layout"] = false,
        ["--border"] = "none",
        ["--highlight-line"] = true,
        ["--cycle"] = true,
        ["--scrollbar"] = "█",
        -- ["--bind"] = "alt-j:down,alt-k:up",
      },
      fzf_colors = {
        true,
        ["fg"] = { "fg", "NormalFloat" },
        ["fg+"] = { "fg", "NormalFloat" },
        ["bg"] = { "bg", "NormalFloat" },
        ["bg+"] = { "bg", "Visual" },
        ["hl"] = { "fg", "Constant" },
        ["hl+"] = { "fg", "Constant" },
        scrollbar = { "bg", "PmenuThumb" },
        query = { "fg", "NormalFloat" },
        separator = { "fg", "NoneFloat" },
        gutter = { "bg", "NoneFloat" },
      },
    })

    require("fzf-lua").register_ui_select({ prompt = "> " })

    vim.keymap.set(
      "n",
      "<Leader>fh",
      require("fzf-lua").helptags,
      { desc = "Find : Help" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fH",
      require("fzf-lua").manpages,
      { desc = "Find : Manuals" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f?",
      require("fzf-lua").keymaps,
      { desc = "Find : Keymaps" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fe",
      require("fzf-lua").files,
      { desc = "Find : Environment" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fz",
      require("fzf-lua").builtin,
      { desc = "Find : Builtin" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f/",
      require("fzf-lua").search_history,
      { desc = "Find : Search History" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f:",
      require("fzf-lua").command_history,
      { desc = "Find : Command History" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f;",
      require("fzf-lua").commands,
      { desc = "Find : Command" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f'",
      require("fzf-lua").marks,
      { desc = "Find : Mark" }
    )

    vim.keymap.set(
      "n",
      '<Leader>f"',
      require("fzf-lua").registers,
      { desc = "Find : Register" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f`",
      require("fzf-lua").highlights,
      { desc = "Find : Highlights" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fv",
      require("fzf-lua").nvim_options,
      { desc = "Find : Options" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fk",
      require("fzf-lua").spell_suggest,
      { desc = "Find : Spelling" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fK",
      require("fzf-lua").spellcheck,
      { desc = "Find : Spellings" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fw",
      require("fzf-lua").grep_cword,
      { desc = "Find : Current Word" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fW",
      require("fzf-lua").grep_cWORD,
      { desc = "Find : Current WORD" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fg",
      require("fzf-lua").live_grep,
      { desc = "Find : Grep" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fd",
      require("fzf-lua").diagnostics_document,
      { desc = "Find : Buffer Diagnostics" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fD",
      require("fzf-lua").diagnostics_workspace,
      { desc = "Find : Project Diagnostics" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fr",
      require("fzf-lua").resume,
      { desc = "Find : Resume" }
    )

    vim.keymap.set(
      "n",
      "<Leader>f.",
      require("fzf-lua").oldfiles,
      { desc = "Find : Recent Files" }
    )

    vim.keymap.set(
      "n",
      "<Leader>ff",
      require("fzf-lua").buffers,
      { desc = "Find : Buffers" }
    )

    vim.keymap.set(
      "n",
      "<Leader>fi",
      require("fzf-lua").lgrep_curbuf,
      { desc = "Find : Inside Buffer" }
    )

    vim.keymap.set("n", "<Leader>f,", function()
      require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Find : Config" })
  end,
}
