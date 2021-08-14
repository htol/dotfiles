local function on_attach()
end

local lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  function(_, _, params, client_id, _)
    local config = { -- your config
      underline = false,
      virtual_text = {
        prefix = '~',
        spacing = 2,
      },
      signs = true,
      update_in_insert = true,
    }
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
      diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
  end


--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--  vim.lsp.diagnostic.on_publish_diagnostics, {
--    underline = false,
--    virtual_text = {
--      spacing = 2,
--      prefix = '~',
--    },
--    signs = true,
--    update_in_insert = true,
--  }
--)

lsp.tsserver.setup{ on_attach=on_attach }

lsp.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

lsp.gopls.setup{
    on_attach=on_attach,
    capabilities=capabilities,
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
}

lsp.pyright.setup{ on_attach=on_attach }

lsp.vuels.setup{ on_attach=on_attach }
lsp.yamlls.setup{ on_attach=on_attach }

lsp.jsonls.setup{
    on_attach=on_attach,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}


--vim.lsp.set_log_level("debug")
