vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  --  use 'hrsh7th/nvim-compe'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-emoji'

  --  use 'tjdevries/nlua.nvim'
  --  use 'tjdevries/lsp_extensions.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Neovim Tree shitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'


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
    use 'gruvbox-community/gruvbox'
    use 'ful1e5/onedark.nvim'
    use 'ghifarit53/tokyonight-vim'

end)
