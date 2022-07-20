require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "go", "python", "c", "cpp", "bash", "html", "javascript",
        "json", "yaml", "lua", "vue", "java", "kotlin", "hcl"
    },
    highlight = { enable = true },

    textobjects = {
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
               ["<leader>pf"] = "@function.outer",
               ["<leader>pc"] = "@class.outer"
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
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true, 
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        }
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, 
        persist_queries = false 
    }
}        
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
