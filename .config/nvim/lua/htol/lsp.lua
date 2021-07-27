-- TODO: dont need with compe???
--local on_attach = require'completion'.on_attach

local lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
