return {
  "mfussenegger/nvim-lint",
  enabled = false,
  config = function()
    require("lint").linters_by_ft = {
      html = { "htmlhint" },
      -- yaml = { "yamllint" },
      markdown = { "markdownlint" },
    }

    require("lint").linters.markdownlint.args = {
      "--disable MD013",
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("uLint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
