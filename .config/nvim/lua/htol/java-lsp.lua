--local on_attach = require'completion'.on_attach
local XDG_CONFIG_HOME = os.getenv('XDG_CONFIG_HOME')

local info = debug.getinfo(1,'S');
print(info.source);

local lsp = require('lspconfig')

lsp.jdtls.setup{
    cmd = {"jdtls.sh"},
    settings = {
        java = {
            signatureHelp = { enabled = true },
            format = {
                comments = { enabled = false },
                settings = {
                    -- https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
                    url = XDG_CONFIG_HOME.."/nvim/lua/htol/java/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
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
