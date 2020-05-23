syntax on

nnoremap <Space> <Nop>
map <Space> <leader>
let mapleader = "\<Space>"

set runtimepath+=~/.local/vim

set autoindent
"set smartident
set expandtab						" replace <Tab> with spaces
set tabstop=4 softtabstop=4
set shiftwidth=4

set nu
set nowrap

set noswapfile
set nobackup
set undodir=~/.config/nvim/vim_undodir
set undofile

set smartcase
set incsearch

set mouse=a

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

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


call plug#begin('~/.config/vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'mbbill/undotree'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif
