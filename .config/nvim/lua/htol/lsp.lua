--local on_attach = require'completion'.on_attach
local GRADLE_USER_HOME = os.getenv('GRADLE_USER_HOME')

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

lsp.jdtls.setup{
    cmd = {"jdtls.sh"},
    settings = {
        java = {
            signatureHelp = { enabled = true },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
--            import = {
--                gradle = {
--                    user = {
--                        home = GRADLE_USER_HOME
--                    }
--                }
--            }
        }
    },
}

--vim.lsp.set_log_level("debug")
