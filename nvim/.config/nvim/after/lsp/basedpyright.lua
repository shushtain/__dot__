-- see : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/basedpyright.lua

local function get_python_path()
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    local venv_python_path = vim.env.VIRTUAL_ENV .. "/bin/python"
    vim.notify("basedpyright python path: " .. venv_python_path)
    return venv_python_path
  end
  local python_path = vim.fn.exepath("python3")
    or vim.fn.exepath("python")
    or "python"
  vim.notify("basedpyright python path: " .. python_path)
  -- Fallback to system Python.
  return python_path
end

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "basedpyright",
  })
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend(
        "force",
        client.settings.python or {},
        { pythonPath = path }
      )
    else
      client.config.settings = vim.tbl_deep_extend(
        "force",
        client.config.settings,
        { python = { pythonPath = path } }
      )
    end
    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return {
  -- basedpyright is installed in a python venv, nvim must be launched after the correct venv has been activated
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = vim.fn.getcwd(),
  -- root_markers = {
  -- 	"pyproject.toml",
  -- 	"setup.py",
  -- 	"setup.cfg",
  -- 	"requirements.txt",
  -- 	"Pipfile",
  -- 	"pyrightconfig.json",
  -- 	".git",
  -- },
  settings = {
    -- see basedpyright.com/language-server-settings
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        -- diagnosticMode = "openFilesOnly",
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "strict",
      },
    },
    python = {
      pythonPath = get_python_path(),
      -- venvPath = vim.env.VIRTUAL_ENV,
    },
  },
  on_attach = function(client, bufnr)
    -- available user command to organize imports
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightOrganizeImports",
      function()
        local params = {
          command = "basedpyright.organizeimports",
          arguments = { vim.uri_from_bufnr(bufnr) },
        }

        -- Using client.request() directly because "basedpyright.organizeimports" is private
        -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
        -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
        ---@diagnostic disable-next-line: param-type-mismatch
        client.request("workspace/executeCommand", params, nil, bufnr)
      end,
      {
        desc = "Organize Imports",
      }
    )
    -- available user command to print the current python path
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightGetPythonPath",
      function()
        print(client.settings.python.pythonPath)
      end,
      {
        desc = "Print the current python path",
      }
    )

    -- available user command to modify the python path
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightSetPythonPath",
      set_python_path,
      {
        desc = "Reconfigure basedpyright with the provided python path",
        nargs = 1,
        complete = "file",
      }
    )
  end,
}
