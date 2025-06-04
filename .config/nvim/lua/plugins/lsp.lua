return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {}, },
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {
            "lua_ls",
            "tailwindcss",
            "emmet_ls",
            "vue_ls",
            "ts_ls",
            "pyright",
            "ruff",
            "clangd",
            "gopls",
            "rust_analyzer",
            "yamlls",
            "jsonls",
            "terraformls",
          }, -- ensure_installed
        },   -- mason-lspconfig opts
      },     -- mason-lspconfig
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    }, -- dependencies
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilites = capabilities }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then return end

          if vim.bo.filetype == "lua" then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
              end,
            })
          end
        end,
      })
    end
  },
}
