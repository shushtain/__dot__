return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    }

    local branch = {
      "branch",
      fmt = function(str, _)
        local diff = vim.b.gitsigns_status
        diff = diff and #diff > 0 and "~" or ""
        return diff .. str .. diff
      end,
    }

    local filename = {
      "filename",
      file_status = true,
      newfile_status = true,
      path = 1,
      symbols = {
        modified = "🞸",
        readonly = "∅",
        unnamed = "⋯",
        newfile = "⧧",
      },
    }

    local diagnostics = {
      "diagnostics",
      padding = { left = 0, right = 1 },
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "info", "hint" },
      symbols = { error = "∙", warn = "∙", info = "∙", hint = "∙" },
      colored = true,
      fmt = function(str, _)
        local dia = str:gsub(" ", "")
        local status = ("∙"):rep(4)
        return #vim.lsp.status() > 0 and status or dia
      end,
    }

    local status = {
      "status",
      padding = { left = 0, right = 1 },
      fmt = function()
        local stats = {
          smart_kbd = vim.g.smart_keyboard and "⌨" or "",
          keymap = vim.o.keymap == "" and "" or "⌥",
          format = vim.g.u_manual_formatting and "⌇" or "",
        }
        stats = vim.tbl_filter(function(val)
          return val ~= ""
        end, stats)
        return vim.fn.join(stats, " ")
      end,
    }

    local filetype = {
      "filetype",
      icons_enabled = false,
      colored = false,
    }

    local location = {
      "location",
    }

    local selection = {
      "selectioncount",
      padding = { left = 0, right = 1 },
      fmt = function(str, _)
        return #str > 0 and "<" .. str:gsub("x", ":") .. ">" or ""
      end,
    }

    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = false,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        ignore_focus = {},
        always_divide_middle = false,
        globalstatus = true,
        refresh = {
          refresh_time = 32,
        },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { filename },
        lualine_x = {
          selection,
          diagnostics,
          status,
        },
        lualine_y = { filetype },
        lualine_z = { location },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { branch },
        lualine_c = { filename },
        lualine_x = { diagnostics },
        lualine_y = { filetype },
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
