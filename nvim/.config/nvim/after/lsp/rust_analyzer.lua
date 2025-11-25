local function is_library(fname)
  local user_home = vim.fs.normalize(vim.env.HOME)
  local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
  local registry = cargo_home .. "/registry/src"
  local git_registry = cargo_home .. "/git/checkouts"

  local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
  local toolchains = rustup_home .. "/toolchains"

  for _, item in ipairs({ toolchains, registry, git_registry }) do
    if vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
end

local meta_cache = {}

---@type vim.lsp.Config
return {
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      assist = {
        preferSelf = true,
      },
      diagnostics = {
        styleLints = {
          enable = true,
        },
        experimental = {
          enable = true,
        },
      },
    },
  },
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    },
  },
  cmd = { "rust-analyzer" },
  root_dir = function(bufnr, on_dir)
    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(cwd .. "/.ignore") == 1 then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    local reused_dir = is_library(fname)
    if reused_dir then
      on_dir(reused_dir)
      return
    end

    local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
    local cargo_workspace_root

    if cargo_crate_dir == nil then
      on_dir(
        vim.fs.root(fname, { "rust-project.json" })
          or vim.fs.dirname(
            vim.fs.find(".git", { path = fname, upward = true })[1]
          )
      )
      return
    end

    if cargo_crate_dir and meta_cache[cargo_crate_dir] then
      on_dir(meta_cache[cargo_crate_dir])
      return
    end

    local cmd = {
      "cargo",
      "metadata",
      "--no-deps",
      "--format-version",
      "1",
      "--manifest-path",
      cargo_crate_dir .. "/Cargo.toml",
    }

    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          local result = vim.json.decode(output.stdout)
          if result["workspace_root"] then
            cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
          end
        end

        local final_root = cargo_workspace_root or cargo_crate_dir
        meta_cache[cargo_crate_dir] = final_root

        on_dir(final_root)
      else
        vim.schedule(function()
          vim.notify(
            ("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(
              output.code,
              cmd,
              output.stderr
            )
          )
        end)
      end
    end)
  end,
  before_init = function(init_params, config)
    if config.settings and config.settings["rust-analyzer"] then
      init_params.initializationOptions = config.settings["rust-analyzer"]
    end
  end,
}
