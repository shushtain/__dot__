---@type vim.lsp.Config
return {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    ["nil"] = {
      formatting = { command = { "nixfmt" } },
      -- diagnostics = { ignored = {} },
      nix = {
        maxMemoryMB = 4096,
        flake = {
          autoArchive = true,
          autoEvalInputs = true,
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
}
