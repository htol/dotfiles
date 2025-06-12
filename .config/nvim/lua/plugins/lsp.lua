return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
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
      -- status updates for LSP.
      { 'j-hui/fidget.nvim',    opts = {} },
    }, -- dependencies

    config = function()
      --vim.lsp.set_log_level("debug")

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- probably not required anymore b.c. of lazydev and there will be two client instead of one
      -- require("lspconfig").lua_ls.setup { capabilites = capabilities }

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            }) -- BufWritePre
          end
        end,
      }) -- LspAttach autocmd
    end, -- config

    opts = {
      servers = {
        gopls = {
          cmd = { "gopls", "serve" },
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
        }, -- gopls

        ts_ls = {},

        clangd = {
          root_dir = function() return vim.uv.cwd() end
        },

        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true
              },
            }
          }
        },

        pyright = {},

        ruff = {
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = {},
            }
          }
        },

        --pylsp={
        --  settings = {
        --    pylsp = {
        --      plugins = {
        --        pycodestyle = {
        --          ignore = {'W391'},
        --          maxLineLength = 88
        --        }
        --      }
        --    }
        --  }
        --},

        volar = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
        },

        yamlls = {},

        jsonls = {
          cmd = { "fnm", "exec", "--using=18", "vscode-json-languageserver" },
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
              end
            }
          }
        },

        terraformls = {},

        emmet_ls = {
          filetypes = { 'html', 'htmldjango', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' },
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
              },
            },
          }
        },

      }, -- servers
    },   -- opts
  },
}
