if not pcall(require, "nvim-treesitter") then
    return
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "go", "python", "c", "cpp", "rust", "bash", "html", "javascript",
        "json", "yaml", "toml", "lua", "vue", "java", "kotlin", "hcl",
        "sql", "query", "vim", "vimdoc"
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
        node_incremental = "<M-w>", -- increment to the upper named parent
        node_decremental = "<M-C-w>", -- decrement to the previous node
        scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
      },
    },

    --context_commentstring = {
    --  enable = true,

    --  -- With Comment.nvim, we don't need to run this on the autocmd.
    --  -- Only run it in pre-hook
    --  enable_autocmd = false,

    --  config = {
    --    c = "// %s",
    --    lua = "-- %s",
    --  },
    --},

    textobjects = {
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
               ["<leader>pf"] = "@function.outer",
               ["<leader>pc"] = "@class.outer",
            }
        },

        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",

                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                ["av"] = "@variable.outer",
                ["iv"] = "@variable.inner",
            }
        },

        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]p"] = "@parameter.inner",
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ["[p"] = "@parameter.inner",
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            }
        }
    },

    playground = {
        enable = true,
        updatetime = 25,
        persist_queries = true,
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",

            -- This shows stuff like literal strings, commas, etc.
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },

    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    }
}

vim.cmd [[highlight IncludedC guibg=#373b41]]

vim.cmd [[nnoremap <space>tp :TSPlaygroundToggle<CR>]]
vim.cmd [[nnoremap <space>th :TSHighlightCapturesUnderCursor<CR>]]
