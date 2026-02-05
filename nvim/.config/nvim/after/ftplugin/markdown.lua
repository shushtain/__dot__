vim.bo.shiftwidth = 2

-- XXX: so, just each color as hl then?

-- vim.keymap.set("n", "<M-i>", function()
--   local node = vim.treesitter.get_node({ ignore_injections = false })
--   if not node then
--     return nil
--   end
--
--   local link
--   while node and not link do
--     if node:type() == "inline_link" or node:type() == "image" then
--       for child in node:iter_children() do
--         if child:type() == "link_destination" then
--           link = vim.treesitter.get_node_text(child, 0)
--           break
--         end
--       end
--     end
--     node = node:parent()
--   end
--
--   print(link)
--   local res = vim
--     .system(
--       { "chafa", "-s", "60x40", "-c", "none", "--symbols=vhalf", link },
--       { cwd = vim.fn.getcwd(), text = false }
--     )
--     :wait(500)
--   if res.code ~= 0 then
--     vim.notify(res.code .. "/" .. res.signal .. ": " .. res.stderr)
--     return
--   end
--   vim.print(res.stdout)
-- end)

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("marksman")
vim.lsp.enable("harper_ls")
