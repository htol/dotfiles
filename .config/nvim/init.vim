set t_Co=256

if &diff
  set relativenumber
else
"   setup for non-diff mode
endif

"let s:portable = expand('<sfile>:p:h')
"exe "source " . s:portable . '/colors_init.vim'

"set list
"set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

syntax on

" go to next/previous changes in diff and center the line on screen
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap <F5> :w<CR>:!python %<CR>

set runtimepath+=~/.local/vim

set exrc
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
set number relativenumber
set nowrap              " do not wrap line of text
set guicursor=
set nohlsearch
set hidden              " do not unload buffers, keep it in background
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.config/nvim/vim_undodir
set undofile
set smartcase
set incsearch
set scrolloff=8
set colorcolumn=120
set signcolumn=yes

set cmdheight=2
set updatetime=50       " default is 4000ms = 4s

" don't pass messages to |ins-completion-menu|.
set shortmess+=c

set mouse=a


if has("autocmd")
  filetype plugin indent on
endif


function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()


call plug#begin('~/.config/nvim/plugged')
  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'tjdevries/nlua.nvim'
  Plug 'tjdevries/lsp_extensions.nvim'

  " telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " Neovim Tree shitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'

  " THE BEST color schema
  Plug 'gruvbox-community/gruvbox'

  Plug 'mbbill/undotree'
  Plug 'tpope/vim-fugitive'
"  Plug 'tweekmonster/gofmt.vim'
call plug#end()

lua require("htol")
lua require'nvim-treesitter.configs'.setup { ensure_installed = {"go", "python", "c", "cpp", "bash", "html", "javascript", "json", "yaml", "lua", "vue"},  highlight = { enable = true }}

set background=dark
" let g:gruvbox_contrast_dark = "soft"
colorscheme gruvbox
"highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight Normal guibg=none

" mode lhs rhs
nnoremap <SPACE> <Nop>
let mapleader =  " "

nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<cr>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<cr>

nnoremap <Leader>W :w !sudo tee % > /dev/null
nnoremap <Leader>w :w
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<cr>
nnoremap <Leader>b :ls<cr>:b<Space>

vnoremap <leader>p "_dP
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" if executable('rg')
"     let g:rg_derive_root='true'
" endif

func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
endfunc

if !has("clipboard") && executable("clip.exe")
    noremap <C-C> :call system('clip.exe', GetSelectedText())<CR>
    noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
endif

set termguicolors
