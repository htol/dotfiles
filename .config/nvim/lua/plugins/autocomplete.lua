return {
    {
        'hrsh7th/nvim-cmp',
        --event = "InsertEnter",
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
}
