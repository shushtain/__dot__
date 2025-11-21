-- vim.lsp.set_log_level("debug")

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})

vim.lsp.enable("typos_lsp")
-- vim.lsp.enable("ltex_enus")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("uLspAttach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    vim.lsp.completion.enable(true, client.id, ev.buf, {
      autotrigger = false,
      convert = function(item)
        return { abbr = item.label:gsub("%b()", "") }
      end,
    })

    if client:supports_method("textDocument/documentHighlight") then
      local group =
        vim.api.nvim_create_augroup("uLspHighlight", { clear = false })
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = ev.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = ev.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if
      not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("uLspFormat", { clear = false }),
        buffer = ev.buf,
        callback = function()
          if not vim.g.u_manual_formatting then
            vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
          end
        end,
      })
    end
  end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("uLspDetach", { clear = true }),
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if not client then
--       return
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("uOmniComplete", {}),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client or not client:supports_method("textDocument/completion") then
--       return
--     end
--
--     vim.lsp.completion.enable(true, client.id, args.buf, {
--       -- autotrigger = true, -- optional
--       convert = function(item)
--         return {
--           -- this is from docs. idk why we delete matching ().
--           -- maybe some suggestions would come with function signature?
--           abbr = item.label:gsub("%b()", ""),
--           -- and this will delete anything after "<label> <kind> ..."
--           -- so no "Emmet Abbr" but no other possible hints either
--           menu = "", -- optional
--           -- if there is no entry for numerical key in registered ItemKind labels,
--           -- then use custom text (could be just "" for nothing)
--           kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "",
--         }
--       end,
--     })
--   end,
-- })
--
-- local kind = vim.lsp.protocol.CompletionItemKind
-- kind[1] = "Text"
-- kind[2] = "Method"
-- kind[3] = "Function"
-- kind[4] = "Constructor"
-- kind[5] = "Field"
-- kind[6] = "Variable"
-- kind[7] = "Class"
-- kind[8] = "Interface"
-- kind[9] = "Module"
-- kind[10] = "Property"
-- kind[11] = "Unit"
-- kind[12] = "Value"
-- kind[13] = "Enum"
-- kind[14] = "Keyword"
-- kind[15] = "Snippet"
-- kind[16] = "Color"
-- kind[17] = "File"
-- kind[18] = "Reference"
-- kind[19] = "Folder"
-- kind[20] = "EnumMember"
-- kind[21] = "Constant"
-- kind[22] = "Struct"
-- kind[23] = "Event"
-- kind[24] = "Operator"
-- kind[25] = "TypeParameter"
