vim.g.mapleader =  " "

--vim.g.t_Co=256
vim.opt.termguicolors = true

vim.opt.guicursor = ""

vim.opt.syntax = 'on'

vim.opt.keymap='russian-jcukenwin'
vim.opt.iminsert=0
vim.opt.imsearch=0

-- setlocal spell spelllang=ru_yo,en_us

vim.opt.runtimepath = vim.opt.runtimepath + "~/.local/vim"
vim.opt.tags = vim.opt.tags + "~/.config/nvim/tags"
vim.opt.tags = vim.opt.tags + "~/.local/nvim/nvim-linux64/share/nvim/runtime/doc/tags"

vim.opt.exrc = true
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true              -- do not wrap line of text
vim.opt.hlsearch = false
vim.opt.hidden = true              -- do not unload buffers, keep it in background
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir='~/.config/nvim/vim_undodir'
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.scrolloff=8
vim.opt.colorcolumn='120'
vim.opt.signcolumn = 'yes'

vim.opt.cmdheight=1
vim.opt.updatetime=50       -- default is 4000ms = 4s

-- don't pass messages to |ins-completion-menu|
vim.opt.shortmess = vim.opt.shortmess + 'c'

vim.opt.mouse='a'

vim.opt.splitbelow = true
vim.opt.splitright = true


-- FILE BROWSER:
vim.g.netrw_banner = 0              -- disable banner
vim.g.netrw_browse_split = 4        -- open in prev window
vim.g.netrw_altv = 1                -- open splits to the right
vim.g.netrw_liststyle = 3           -- tree view
vim.g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore
-- check |netrw-browse-maps| for mappings


-- disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/home/tol/.local/pyenv/versions/neovim3/bin/python'
