local M = {}
local home = os.getenv('HOME')

-- set completeopt=menuone,noinsert,noselect
-- let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
-- nnoremap <leader>vD :lua vim.lsp.buf.declaration()<CR>
-- nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
-- nnoremap gd :lua vim.lsp.buf.definition()<CR>
-- nnoremap gt :lua vim.lsp.buf.type_definition()<CR>
-- nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
-- nnoremap gi :lua vim.lsp.buf.implementation()<CR>
-- nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
-- nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
-- nnoremap K :lua vim.lsp.buf.hover()<CR>
-- nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
-- nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
-- nnoremap <leader>vf :lua vim.lsp.buf.formatting()<CR>

-- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
local key_mappings = {
  {"documentFormattingProvider", "n", "gq", "<Cmd>lua vim.lsp.buf.formatting{async = true}<CR>"},
  {"documentRangeFormattingProvider", "v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
  {"referencesProvider", "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>"},
  {"hoverProvider", "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
  {"implementationProvider", "n", "gD",  "<Cmd>lua vim.lsp.buf.implementation()<CR>"},
  {"signatureHelpProvider", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
  {"workspaceSymbolProvider", "n", "gW", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"},
  {"codeActionProvider", "n", "<a-a>", "<Cmd>lua vim.lsp.buf.code_action()<CR>"},
  {"codeActionProvider", "n", "<leader>r", "<Cmd>lua vim.lsp.buf.code_action { only = 'refactor' }<CR>"},
  {"codeActionProvider", "v", "<a-a>", "<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>"},
  {"codeActionProvider", "v", "<leader>r", "<Esc><Cmd>lua vim.lsp.buf.range_code_action { only = 'refactor'}<CR>"},
}

local function on_attach(client, bufnr)
  -- works with 0.7.0
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})

  --vim.api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
  --vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  --vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")

  -- Probably redundunt option
  vim.api.nvim_command("setlocal signcolumn=yes")
  vim.api.nvim_buf_set_option(bufnr, 'tagfunc', "v:lua.vim.lsp.tagfunc")


  local opts = { silent = true; }
  for _, mappings in pairs(key_mappings) do
    local capability, mode, lhs, rhs = unpack(mappings)
    if client.server_capabilities[capability] then
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "crr", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<c-n>", "<Cmd>lua require('lsp_compl').trigger_completion()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]w", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[w", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)

  vim.cmd('augroup lsp_aucmds')
  vim.cmd(string.format('au! * <buffer=%d>', bufnr))
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd(string.format('au CursorHold  <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
    vim.cmd(string.format('au CursorHoldI <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
    vim.cmd(string.format('au CursorMoved <buffer=%d> lua vim.lsp.buf.clear_references()', bufnr))
  end
  if vim.lsp.codelens and client.server_capabilities.codeLensProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<Cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ce", "<Cmd>lua vim.lsp.codelens.run()<CR>", opts)
  end
  vim.cmd('augroup end')

end
M.on_attach = on_attach

local lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = {
      spacing = 2,
      prefix = '~',
    },
    signs = true,
    update_in_insert = true,
  }
)

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
        usePlaceholders = true,
        --linksInHover = false,
        codelenses = {
            generate = true,
            gc_details = true,
            regenerate_cgo = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
        },
      },
    },
}

lsp.pyright.setup{ on_attach=on_attach, capabilities=capabilities, }

lsp.vuels.setup{ on_attach=on_attach, capabilities=capabilities, }

lsp.yamlls.setup{ on_attach=on_attach, capabilities=capabilities, }

lsp.jsonls.setup{
    on_attach=on_attach,
    capabilities=capabilities,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}


local sumneko_root_path = home .. '/.local/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach=on_attach,
  capabilities=capabilities,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.terraformls.setup {
  on_attach=on_attach,
  capabilities=capabilities,
}

--vim.lsp.set_log_level("debug")
M.capabilities = capabilities
return M
