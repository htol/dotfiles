-- Original at https://raw.githubusercontent.com/mfussenegger/dotfiles/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua
local jdtls = require('jdtls')
local root_markers = {'gradlew', '.git', 'mvnw'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local capabilities = require('htol.lsp').capabilities
local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")


local config = {
    flag = {
        allow_incremental_sync = true,
        server_side_fuzzy_completion = true,
    },
    capabilities = capabilities,
    root_dir = root_dir,
    handlers = {},

    on_init = function(client)
        if client.config.settings then
            client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end
    end,

    on_attach = function(client, bufnr)
        require('htol.lsp').on_attach(client, bufnr)
        -- jdtls.setup_dap({hotcodereplace = 'auto'})
        jdtls.setup.add_commands()
        local opts = { silent = true, buffer = bufnr }
        vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
        vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
        vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
        vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
        vim.keymap.set('v', 'crv', [[<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>]], opts)
        vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
        vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
        vim.keymap.set('v', 'crc', [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], opts)
        local create_command = vim.api.nvim_buf_create_user_command
        create_command(bufnr, 'W', require('me.lsp.ext').remove_unused_imports, {
          nargs = 0,
        })
    end,


    cmd = {
-- have to find out howto pass environment variables
--        'GRADLE_HOME=' .. home .. '/.local/sdkman/candidates/gradle/current ' ..
--        'JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 ' ..
--        '/usr/lib/jvm/java-11-openjdk-amd64/bin/java',
--        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--        '-Dosgi.bundles.defaultStartLevel=4',
--        '-Declipse.product=org.eclipse.jdt.ls.core.product',
--        '-Dlog.protocol=true',
--        '-Dlog.level=ALL',
--        '-Xmx4g',
--        '--add-modules=ALL-SYSTEM',
--        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--        '-jar', vim.fn.glob(home .. '/.local/jdt-ls/plugins/org.eclipse.equinox.launcher_*.jar'),
--        '-configuration', home .. '/.local/jdt-ls/config_linux',
--        '-data', workspace_folder,
        home .. '/.local/bin/nvim-jdtls.sh',
        workspace_folder,
      },
}

config.settings = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  java = {
    signatureHelp = { enabled = true };
    format = {
        comments = { enabled = false },
        settings = {
            -- https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
            url = home .. "/nvim/lua/htol/java/eclipse-java-google-style.xml",
            profile = "GoogleStyle",
        },
    },
    contentProvider = { preferred = 'fernflower' };
    completion = {
      favoriteStaticMembers = {
       -- "org.hamcrest.MatcherAssert.assertThat",
       -- "org.hamcrest.Matchers.*",
       -- "org.hamcrest.CoreMatchers.*",
       -- "org.junit.jupiter.api.Assertions.*",
       -- "java.util.Objects.requireNonNull",
       -- "java.util.Objects.requireNonNullElse",
       -- "org.mockito.Mockito.*"
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
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
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    };
    configuration = {
      runtimes = {
--        {
--          name = "JavaSE-1.8",
--          path = "/usr/lib/jvm/java-8-openjdk/",
--        },
        {
          name = "JavaSE-11",
          path = "/usr/lib/jvm/java-11-openjdk-amd64/",
        },
--        {
--          name = "JavaSE-16",
--          path = home .. "/.local/jdks/jdk-16.0.1+9/",
--        },
--        {
--          name = "JavaSE-17",
--          path = home .. "/.local/jdks/jdk-17.0.2+8/",
--        },
      }
    };
  };
}

--local jar_patterns = {
--  '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
--  '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
--  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
--  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
--  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
--  '/dev/testforstephen/vscode-pde/server/*.jar'
--}
-- npm install broke for me: https://github.com/npm/cli/issues/2508
-- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
--local plugin_path = '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
--local bundle_list = vim.tbl_map(
--  function(x) return require('jdtls.path').join(plugin_path, x) end,
--  {
--    'org.eclipse.jdt.junit4.runtime_*.jar',
--    'org.eclipse.jdt.junit5.runtime_*.jar',
--    'org.junit.jupiter.api*.jar',
--    'org.junit.jupiter.engine*.jar',
--    'org.junit.jupiter.migrationsupport*.jar',
--    'org.junit.jupiter.params*.jar',
--    'org.junit.vintage.engine*.jar',
--    'org.opentest4j*.jar',
--    'org.junit.platform.commons*.jar',
--    'org.junit.platform.engine*.jar',
--    'org.junit.platform.launcher*.jar',
--    'org.junit.platform.runner*.jar',
--    'org.junit.platform.suite.api*.jar',
--    'org.apiguardian*.jar'
--  }
--)
--vim.list_extend(jar_patterns, bundle_list)
local bundles = {}
--for _, jar_pattern in ipairs(jar_patterns) do
--  for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
--    if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
--      and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
--      table.insert(bundles, bundle)
--    end
--  end
--end

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}
-- mute; having progress reports is enough
--config.handlers['language/status'] = function() end
jdtls.start_or_attach(config)
