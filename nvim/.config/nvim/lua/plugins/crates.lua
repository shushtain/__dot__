return {
  "saecki/crates.nvim",
  enabled = false,
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
      { silent = true, desc = "LSP : Crates : Toggle" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcr",
      require("crates").reload,
      { silent = true, desc = "LSP : Crates : Reload" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcv",
      require("crates").show_versions_popup,
      { silent = true, desc = "LSP : Crates : Versions" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcf",
      require("crates").show_features_popup,
      { silent = true, desc = "LSP : Crates : Features" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcd",
      require("crates").show_dependencies_popup,
      { silent = true, desc = "LSP : Crates : Dependencies" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcu",
      require("crates").update_crate,
      { silent = true, desc = "LSP : Crates : Update" }
    )
    vim.keymap.set(
      "v",
      "<Leader>pcu",
      require("crates").update_crates,
      { silent = true, desc = "LSP : Crates : Update" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pca",
      require("crates").update_all_crates,
      { silent = true, desc = "LSP : Crates : Update All" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcU",
      require("crates").upgrade_crate,
      { silent = true, desc = "LSP : Crates : Upgrade" }
    )
    vim.keymap.set(
      "v",
      "<Leader>pcU",
      require("crates").upgrade_crates,
      { silent = true, desc = "LSP : Crates : Upgrade" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcA",
      require("crates").upgrade_all_crates,
      { silent = true, desc = "LSP : Crates : Upgrade All" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcx",
      require("crates").expand_plain_crate_to_inline_table,
      { silent = true, desc = "LSP : Crates : Expand Inline" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcX",
      require("crates").extract_crate_into_table,
      { silent = true, desc = "LSP : Crates : Expand Block" }
    )

    vim.keymap.set(
      "n",
      "<Leader>pcH",
      require("crates").open_homepage,
      { silent = true, desc = "LSP : Crates : Home" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcR",
      require("crates").open_repository,
      { silent = true, desc = "LSP : Crates : Repo" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcD",
      require("crates").open_documentation,
      { silent = true, desc = "LSP : Crates : Docs" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcC",
      require("crates").open_crates_io,
      { silent = true, desc = "LSP : Crates : crates.io" }
    )
    vim.keymap.set(
      "n",
      "<Leader>pcL",
      require("crates").open_lib_rs,
      { silent = true, desc = "LSP : Crates : lib.rs" }
    )
  end,
}
