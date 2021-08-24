--local on_attach = require'completion'.on_attach
local XDG_CONFIG_HOME = os.getenv('XDG_CONFIG_HOME')

-- TODO: require from lsp.lua?
-- local function on_attach()
-- end

local lsp = require('vim.lsp')
local lsp_ext = require('lsp-ext')
local lsp_diag = require('lsp-diagnostics')
local jdtls = require('jdtls')
local api = vim.api

-- lsp.jdtls.setup{
--     on_attach=on_attach,
--     cmd = {"jdtls.sh"},
--     settings = {
--         java = {
--             signatureHelp = { enabled = true },
--             format = {
--                 comments = { enabled = false },
--                 settings = {
--                     -- https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
--                     url = XDG_CONFIG_HOME.."/nvim/lua/htol/java/eclipse-java-google-style.xml",
--                     profile = "GoogleStyle",
--                 },
--             },
--             sources = {
--                 organizeImports = {
--                     starThreshold = 9999,
--                     staticStarThreshold = 9999,
--                 },
--             },
-- --            import = {
-- --                gradle = {
-- --                    user = {
-- --                        home = GRADLE_USER_HOME
-- --                    }
-- --                }
-- --            }
--         }
--     },
-- }
local function on_init(client)
  lsp_ext.setup()
  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end


-- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
local key_mappings = {
    {"code_action", "n", "<a-CR>", "<Cmd>lua require'jdtls'.code_action()<CR>"},
    {"code_action", "n", "<leader>r", "<Cmd>lua require'jdtls'.code_action(false, 'refactor')<CR>"},
    {"code_action", "v", "<a-CR>", "<Esc><Cmd>lua require'jdtls'.code_action(true)<CR>"},
    {"code_action", "v", "<leader>r", "<Esc><Cmd>lua require'jdtls'.code_action(true, 'refactor')<CR>"},

    {"document_formatting", "n", "gq", "<Cmd>lua vim.lsp.buf.formatting()<CR>"},
    {"document_range_formatting", "v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
    {"find_references", "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>"},
    {"hover", "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
    {"implementation", "n", "gD",  "<Cmd>lua vim.lsp.buf.implementation()<CR>"},
    {"signature_help", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
    {"workspace_symbol", "n", "gW", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"}
}

local function on_attach(client, bufnr)
    lsp_ext.attach(client, bufnr)
    api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    api.nvim_buf_set_option(bufnr, "bufhidden", "hide")
    api.nvim_command("setlocal signcolumn=yes")

    if client.resolved_capabilities.goto_definition then
      api.nvim_buf_set_option(bufnr, 'tagfunc', "v:lua.lsp_ext.tagfunc")
    end
    local opts = { silent = true; }
    for _, mappings in pairs(key_mappings) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end
    api.nvim_buf_set_keymap(bufnr, "n", "<F6>", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "crr", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "]w", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "[w", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "i", "<c-n>", "<Cmd>lua require('lsp-ext').trigger_completion()<CR>", opts)
    if client.resolved_capabilities['document_highlight'] then
      api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
      api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
end

local function jdtls_on_attach(client, bufnr)
    on_attach(client, bufnr)
    local opts = { silent = true; }
    -- jdtls.setup_dap()
    jdtls.setup.add_commands()
    api.nvim_buf_set_keymap(bufnr, "n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

end

local function mk_config()
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    flags = {
      allow_incremental_sync = true,
    };
    handlers = {
      ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
    };
    capabilities = capabilities;
    on_init = on_init;
    on_attach = on_attach;
  }
end

local M = {}

function M.start_jdt()
  local root_markers = {'gradlew', '.git'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local home = os.getenv('HOME')
  local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = mk_config()
  config.flags.server_side_fuzzy_completion = true
  config.settings = {
    java = {
      signatureHelp = { enabled = true };
      format = {
          comments = { enabled = false },
          settings = {
              -- https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
              url = XDG_CONFIG_HOME.."/nvim/lua/htol/java/eclipse-java-google-style.xml",
              profile = "GoogleStyle",
          },
      },
      contentProvider = { preferred = 'fernflower' };
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      };
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      };
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk-amd64/",
          },
--          {
--            name = "JavaSE-15",
--            path = "/usr/lib/jvm/java-15-openjdk/",
--          },
        }
      };
    };
  }
  config.cmd = {'nvim-jdtls.sh', workspace_folder}
  config.on_attach = jdtls_on_attach

  local jar_patterns = {
--    '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
--    '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
--    '/dev/microsoft/vscode-java-test/server/*.jar',
  }
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
      if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
        table.insert(bundles, bundle)
      end
    end
  end
  local extendedClientCapabilities = jdtls.extendedClientCapabilities;
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
  config.init_options = {
    bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities;
  }
  jdtls.start_or_attach(config)
end

return M
