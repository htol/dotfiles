local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  --  use 'hrsh7th/nvim-compe'
  use 'onsails/lspkind-nvim'

  -- autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-emoji'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip' -- depends on L3MON4D3/LuaSnip

  --  use 'tjdevries/nlua.nvim'
  --  use 'tjdevries/lsp_extensions.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Neovim Tree shitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use 'nvim-treesitter/playground'

  -- code outline
  use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup() end
    }
  use 'simrat39/symbols-outline.nvim'

  use 'mbbill/undotree'
  -- Git
  use 'tpope/vim-fugitive'
  --  use 'tweekmonster/gofmt.vim'


    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    use {
      "mhinz/vim-startify",
      cmd = { "SLoad", "SSave" },
      config = function()
        vim.g.startify_disable_at_vimenter = true
      end,
    }

    --
    -- Themes
    --
    use {
        'gruvbox-community/gruvbox',
        config = function()
            vim.cmd('colorscheme gruvbox')
            --vim.opt.background='dark'
            vim.cmd('highlight Normal guibg=none')
        end
    }
    use 'ful1e5/onedark.nvim'
    --use 'folke/tokyonight.nvim'
    use {
        'sonph/onehalf',
        rtp = 'vim',
    }

    -- startup screen
    -- use 'goolord/alpha-nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
