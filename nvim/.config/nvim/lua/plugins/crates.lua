return {
  "saecki/crates.nvim",
  -- enabled = false,
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  config = function()
    require("crates").setup({
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
      completion = {
        crates = {
          enabled = true,
        },
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>pct",
      require("crates").toggle,
      { desc = "LSP : Crates : Toggle" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcr",
      require("crates").reload,
      { desc = "LSP : Crates : Reload" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcv",
      require("crates").show_versions_popup,
      { desc = "LSP : Crates : Versions" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcf",
      require("crates").show_features_popup,
      { desc = "LSP : Crates : Features" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcd",
      require("crates").show_dependencies_popup,
      { desc = "LSP : Crates : Dependencies" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcu",
      require("crates").update_crate,
      { desc = "LSP : Crates : Update" }
    )
    vim.keymap.set(
      "x",
      "<Leader>pcu",
      require("crates").update_crates,
      { desc = "LSP : Crates : Update" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pca",
      require("crates").update_all_crates,
      { desc = "LSP : Crates : Update All" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcU",
      require("crates").upgrade_crate,
      { desc = "LSP : Crates : Upgrade" }
    )
    vim.keymap.set(
      "x",
      "<Leader>pcU",
      require("crates").upgrade_crates,
      { desc = "LSP : Crates : Upgrade" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcA",
      require("crates").upgrade_all_crates,
      { desc = "LSP : Crates : Upgrade All" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcx",
      require("crates").expand_plain_crate_to_inline_table,
      { desc = "LSP : Crates : Expand Inline" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcX",
      require("crates").extract_crate_into_table,
      { desc = "LSP : Crates : Expand Block" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcH",
      require("crates").open_homepage,
      { desc = "LSP : Crates : Home" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcR",
      require("crates").open_repository,
      { desc = "LSP : Crates : Repo" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcD",
      require("crates").open_documentation,
      { desc = "LSP : Crates : Docs" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcC",
      require("crates").open_crates_io,
      { desc = "LSP : Crates : crates.io" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcL",
      require("crates").open_lib_rs,
      { desc = "LSP : Crates : lib.rs" }
    )
  end,
}
