nnoremap <Space> <Nop>
let mapleader = "\<Space>"

set t_Co=256


if &diff
  set relativenumber
else
"   setup for non-diff mode
endif

let s:portable = expand('<sfile>:p:h')
exe "source " . s:portable . '/colors_init.vim'

"set list
"set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

syntax on

" go to next/previous changes in diff and center the line on screen
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap <F5> :w<CR>:!python %<CR>

set runtimepath+=~/.local/vim

set autoindent
"set smartident
set expandtab						" replace <Tab> with spaces
set tabstop=4 softtabstop=4
set shiftwidth=4

set nu
set nowrap

" set noswapfile
" set nobackup
" set undodir=~/.config/nvim/vim_undodir
" set undofile

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
" Plug 'mbbill/undotree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

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


set relativenumber
