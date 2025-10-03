---@type vim.lsp.Config
return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = true,
          executable = "pylint",
          args = {
            "--disable=C0413,C0411",
          },
        },
        autopep8 = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
        mccabe = {
          enabled = false,
        },
      },
    },
  },
}
