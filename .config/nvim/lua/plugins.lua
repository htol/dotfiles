local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- LSP
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    'onsails/lspkind-nvim',

    -- autocomplete
    {
        'hrsh7th/nvim-cmp',
       dependencies = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-emoji',
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    'saadparwaiz1/cmp_luasnip', -- depends on L3MON4D3/LuaSnip
                    'rafamadriz/friendly-snippets', -- snippets
                },
            }
        }
    },

    --  use 'tjdevries/nlua.nvim'
    --  use 'tjdevries/lsp_extensions.nvim'
    'mfussenegger/nvim-jdtls',

    -- telescope
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',

    -- Neovim Tree shitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        version = nil,
    },
    'nvim-treesitter/nvim-treesitter-textobjects',

    -- code outline
    {
        'stevearc/aerial.nvim',
        config = true,
    },
    'simrat39/symbols-outline.nvim',

    'mbbill/undotree',
    -- Git
    'tpope/vim-fugitive',

    {
        'numToStr/Comment.nvim',
        config = true,
    },

    {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    'lewis6991/gitsigns.nvim', -- Add git related info in the signs columns and popups

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    {
        "mhinz/vim-startify",
        cmd = { "SLoad", "SSave" },
        config = function()
            vim.g.startify_disable_at_vimenter = true
        end,
    },

    --
    -- Themes
    --
    -- use {
    --     'gruvbox-community/gruvbox',
    --     config = function()
    --         --vim.cmd('colorscheme gruvbox')
    --         --vim.opt.background='dark'
    --         vim.cmd('highlight Normal guibg=none')
    --     end
    -- }
    -- use 'ful1e5/onedark.nvim'
    --use 'folke/tokyonight.nvim'
    {
        'LunarVim/lunar.nvim',
        config = function()
            vim.cmd('colorscheme lunar')
        end
    },

    -- startup screen
    -- use 'goolord/alpha-nvim'
})
