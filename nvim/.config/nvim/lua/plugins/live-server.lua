return {
  "barrett-ruth/live-server.nvim",
  enabled = vim.env.NVIM_NOIDE == nil,
  build = "npm install -g live-server",
  config = function()
    require("live-server").setup({
      args = {
        "--port=8080",
        "--browser=chromium",
      },
    })

    local offset = ""
    vim.keymap.set("n", "<Leader>tl", function()
      vim.cmd("LiveServerToggle " .. offset)
    end, { desc = "Toggle : Live Server" })
  end,
}
