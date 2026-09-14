---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { features = "all" },
      assist = { preferSelf = true },
      diagnostics = {
        styleLints = { enable = true },
        experimental = { enable = true },
      },
    },
  },
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    },
  },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    local library = nil
    local places = {
      (vim.env.CARGO_HOME or (vim.env.HOME .. "/.cargo")) .. "/registry/src",
      (vim.env.CARGO_HOME or (vim.env.HOME .. "/.cargo")) .. "/git/checkouts",
      (vim.env.RUSTUP_HOME or (vim.env.HOME .. "/.rustup")) .. "/toolchains",
    }
    for _, item in ipairs(places) do
      if vim.fs.relpath(item, fname) then
        local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
        if #clients > 0 then
          library = clients[#clients].config.root_dir
          break
        end
      end
    end
    if library then ---@diagnostic disable-line: unnecessary-if
      on_dir(library)
      return
    end

    local crate = vim.fs.root(fname, { "Cargo.toml" })
    if not crate then
      on_dir(vim.fs.root(fname, { "rust-project.json", ".git" }))
      return
    end

    vim.system({
      "cargo",
      "metadata",
      "--no-deps",
      "--offline",
      "--format-version",
      "1",
      "--manifest-path",
      crate .. "/Cargo.toml",
    }, { text = true }, function(output)
      local workspace
      if output.code == 0 and output.stdout then
        local result = vim.json.decode(output.stdout)
        if result["workspace_root"] then
          workspace = vim.fs.normalize(result["workspace_root"])
        end
      end
      on_dir(workspace or crate)
    end)
  end,
  before_init = function(init_params, config)
    if config.settings and config.settings["rust-analyzer"] then
      ---@diagnostic disable-next-line: assign-type-mismatch
      init_params.initializationOptions = config.settings["rust-analyzer"]
    end
  end,
}
