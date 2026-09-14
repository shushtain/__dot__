return {
  "barrettruth/live-server.nvim",
  enabled = vim.env.NVIM_NOIDE == nil,
  build = "npm install -g live-server",
  config = function()
    vim.g.live_server = {
      args = {
        "--port=8080",
        "--browser=chromium",
      },
    }

    vim.keymap.set("n", "<Leader>tl", function()
      require("live-server").toggle(vim.fn.getcwd())
    end, { desc = "Toggle : Live Server" })
  end,
}
