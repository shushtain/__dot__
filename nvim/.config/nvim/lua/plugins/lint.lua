return {
  "mfussenegger/nvim-lint",
  -- enabled = vim.env.NVIM_NOIDE == nil,
  enabled = false,
  config = function()
    require("lint").linters_by_ft = {
      html = { "htmlhint" },
      markdown = { "markdownlint" },
    }

    require("lint").linters.markdownlint.args = {
      "--disable MD013",
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
